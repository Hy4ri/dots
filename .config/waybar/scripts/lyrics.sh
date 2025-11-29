#!/usr/bin/env python3

import sys
import subprocess
import json
import urllib.request
import urllib.parse
import os
import hashlib
import time
import re

CACHE_DIR = os.path.expanduser("~/.cache/lyrics")
LOCK_DIR = os.path.join(CACHE_DIR, "locks")

def ensure_dirs():
    os.makedirs(CACHE_DIR, exist_ok=True)
    os.makedirs(LOCK_DIR, exist_ok=True)

class PlayerManager:
    def __init__(self):
        self.player = None

    def get_active_player(self):
        try:
            # Get list of players
            result = subprocess.run(['playerctl', '-l'], capture_output=True, text=True)
            players = result.stdout.strip().split('\n')
            
            # Priority list
            priorities = ['spotify', 'com.spotify.Client', 'spotifyd', 'spotify_player']
            
            # Check for playing status first
            for p in players:
                if not p: continue
                status = self._get_player_status(p)
                if status == "Playing":
                    self.player = p
                    return p

            # Fallback to priority list if nothing is playing
            for prio in priorities:
                for p in players:
                    if p.startswith(prio):
                        self.player = p
                        return p
            
            # Fallback to first available
            if players and players[0]:
                self.player = players[0]
                return players[0]
                
        except Exception:
            pass
        return None

    def _get_player_status(self, player):
        try:
            result = subprocess.run(['playerctl', '-p', player, 'status'], capture_output=True, text=True)
            return result.stdout.strip()
        except:
            return "Stopped"

    def get_metadata(self):
        if not self.player:
            return None
        
        try:
            # Get all metadata in one go
            cmd = ['playerctl', '-p', self.player, 'metadata', '--format', '{{title}}|||{{artist}}|||{{position}}|||{{mpris:length}}']
            result = subprocess.run(cmd, capture_output=True, text=True)
            if result.returncode != 0:
                return None
                
            parts = result.stdout.strip().split('|||')
            if len(parts) < 3:
                return None
                
            title = parts[0]
            artist = parts[1]
            position = parts[2] # in microseconds
            length = parts[3] if len(parts) > 3 else "0"
            
            if not position: position = "0"
            
            return {
                "title": title,
                "artist": artist,
                "position": int(float(position)) / 1000000, # convert to seconds
                "length": int(length)
            }
        except Exception:
            return None

class LyricsFetcher:
    def get_cache_path(self, query):
        hash_obj = hashlib.md5(query.encode())
        return os.path.join(CACHE_DIR, hash_obj.hexdigest())

    def fetch(self, title, artist):
        query = f"{title} {artist}"
        cache_path = self.get_cache_path(query)
        
        if os.path.exists(cache_path):
            with open(cache_path, 'r') as f:
                return f.read()
        
        # Fetch from LRCLib
        try:
            params = urllib.parse.urlencode({'q': query})
            url = f"https://lrclib.net/api/search?{params}"
            
            with urllib.request.urlopen(url, timeout=5) as response:
                data = json.loads(response.read().decode())
                
            if isinstance(data, list) and len(data) > 0:
                # Find first synced lyrics
                for item in data:
                    if item.get('syncedLyrics'):
                        lyrics = item['syncedLyrics']
                        with open(cache_path, 'w') as f:
                            f.write(lyrics)
                        return lyrics
                        
            return None
        except Exception:
            return None

class LrcParser:
    def parse(self, lrc_content):
        lines = []
        for line in lrc_content.split('\n'):
            match = re.match(r'\[(\d+):(\d+\.?\d*)\](.*)', line)
            if match:
                minutes = int(match.group(1))
                seconds = float(match.group(2))
                timestamp = minutes * 60 + seconds
                text = match.group(3).strip()
                lines.append({'time': timestamp, 'text': text})
        return lines

    def get_current_index(self, lines, position):
        idx = -1
        for i, line in enumerate(lines):
            if position >= line['time']:
                idx = i
            else:
                break
        return idx

    def get_context(self, lines, current_idx):
        if current_idx == -1:
            return []
        
        start = max(0, current_idx - 2)
        end = min(len(lines), current_idx + 3)
        
        context = []
        for i in range(start, end):
            text = lines[i]['text']
            if not text:
                line_content = "♫"
            else:
                line_content = f"♪ {text}"
                
            prefix = "<b>" if i == current_idx else ""
            suffix = "</b>" if i == current_idx else ""
            context.append(f"{prefix}{line_content}{suffix}")
            
        return context

def main():
    ensure_dirs()
    
    output = {
        "text": "",
        "tooltip": "",
        "class": "custom-lyrics"
    }

    try:
        player_mgr = PlayerManager()
        player = player_mgr.get_active_player()
        
        if not player:
            print(json.dumps(output))
            return

        meta = player_mgr.get_metadata()
        if not meta:
            print(json.dumps(output))
            return

        # 1. Pause Indicator
        status = player_mgr._get_player_status(player)
        pause_icon = "⏸ " if status == "Paused" else ""

        output['text'] = f"{pause_icon}{meta['title']} - {meta['artist']}"
        output['tooltip'] = f"{meta['title']} - {meta['artist']}"

        # 4. Progress Time
        if meta['length'] > 0:
            def format_time(seconds):
                m = int(seconds // 60)
                s = int(seconds % 60)
                return f"{m:02d}:{s:02d}"

            pos_str = format_time(meta['position'])
            len_str = format_time(meta['length'] / 1000000)
            time_str = f"[{pos_str}/{len_str}]"
            output['tooltip'] += f"\n{time_str}"

        fetcher = LyricsFetcher()
        lrc_content = fetcher.fetch(meta['title'], meta['artist'])
        
        if lrc_content:
            parser = LrcParser()
            lines = parser.parse(lrc_content)
            current_idx = parser.get_current_index(lines, meta['position'])
            
            if current_idx != -1:
                current_text = lines[current_idx]['text']
                if not current_text:
                    output['text'] = f"{pause_icon}♫"
                else:
                    output['text'] = f"{pause_icon}{current_text}"
                
                context = parser.get_context(lines, current_idx)
                # Insert time string before lyrics context
                if meta['length'] > 0:
                     output['tooltip'] = f"{meta['title']} - {meta['artist']}\n{time_str}\n\n" + "\n".join(context)
                else:
                     output['tooltip'] = f"{meta['title']} - {meta['artist']}\n\n" + "\n".join(context)
                
    except Exception as e:
        output['tooltip'] = str(e)
        
    print(json.dumps(output))

if __name__ == "__main__":
    main()
