set -euo pipefail

echo "Установка системы мониторинга"

sudo mkdir -p /etc/monitor-app

sudo cp config.env /etc/monitor-app/config.env

sudo cp monitor.sh /usr/local/bin/monitor.sh

sudo chmod +x /usr/local/bin/monitor.sh

APP_PATH=$(realpath app.py)

sudo sed -i "s|/path/to/app.py|$APP_PATH|" /etc/monitor-app/config.env

sudo cp service/monitor.service /etc/systemd/system/monitor.service

sudo systemctl daemon-reload

sudo systemctl enable monitor.service

sudo systemctl start monitor.service

echo "Установка завершена"
