### Systemd Unit

- Run one of the following commands to activate the service for your user
  - `systemctl --user enable --now prayer-times.service # start on boot`
  - `systemctl --user enable --now prayer-times.timer # start on boot + every 8 hours`
