FROM python:3.10-alpine3.15

ENV PYTHONUNBUFFERED 1

RUN addgroup -S app && adduser -S app -G app

WORKDIR /app
ADD requirements.txt .

RUN apk add --no-cache --virtual .build-deps gcc libc-dev make; \
    pip install --upgrade pip; \
    pip install --no-cache-dir -r requirements.txt; \
    apk del .build-deps gcc libc-dev make;

ADD . .

RUN chown -R app:app .

USER app

EXPOSE 8000