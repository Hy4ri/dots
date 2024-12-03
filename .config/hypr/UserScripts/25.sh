#!/bin/bash

run25(){
termdown 1500 -T Grind && notify-send "Grind Done"
termdown 300 -T Break && notify-send "Break Finshed"
}

while true; do
    run25
done
