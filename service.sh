#!/bin/bash

PID_FILE="/tmp/myservice.pid"

start_service() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")

        if kill -0 "$PID" 2>/dev/null; then
            echo "Уже запущен (PID $PID)"
            return
        else
            rm "$PID_FILE"
        fi
    fi

    sleep 3600 &
    PID=$!

    echo "$PID" > "$PID_FILE"

    echo "Запущен (PID $PID)"
}

stop_service() {
    if [ ! -f "$PID_FILE" ]; then
        echo "Сервис не запущен"
        return
    fi

    PID=$(cat "$PID_FILE")

    if kill -0 "$PID" 2>/dev/null; then
        kill "$PID"
        echo "Остановлен (PID $PID)"
    else
        echo "Процесс уже не существует"
    fi

    rm "$PID_FILE"
}

status_service() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")

        if kill -0 "$PID" 2>/dev/null; then
            echo "Работает (PID $PID)"
        else
            echo "Не работает"
        fi
    else
        echo "Не работает"
    fi
}

help_service() {
    echo "Использование: ./service.sh {start|stop|status|help}"
}

case "$1" in
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    status)
        status_service
        ;;
    help)
        help_service
        ;;
    "")
        help_service
        ;;
    *)
        echo "Ошибка: неизвестная команда" >&2
        exit 1
        ;;
esac

