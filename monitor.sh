set -euo pipefail

source /etc/monitor-app/config.env

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    if curl -s "http://localhost:${APP_PORT}" > /dev/null; then
        echo "$TIMESTAMP — OK: приложение работает" >> "$LOG_FILE"
    else
        echo "$TIMESTAMP — ERROR: приложение недоступно, перезапускаем..." >> "$LOG_FILE"
        pkill -f "app.py" || true
        nohup bash -c "$APP_START_CMD" >> "$LOG_FILE" 2>&1 &
        echo "$TIMESTAMP — Приложение перезапущено" >> "$LOG_FILE"
    fi

    sleep "$CHECK_INTERVAL"
done
