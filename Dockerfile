FROM python:3.11-slim

WORKDIR /app

# Установим необходимые системные библиотеки
RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    libssl-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Скопируем файл зависимостей и установим их
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь проект внутрь контейнера
COPY . .

# Запуск ASGI-приложения
CMD ["daphne", "-b", "0.0.0.0", "-p", "10000", "mysite.asgi:application"]
