FROM python:3.11-alpine

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    musl-dev \
    postgresql-dev \
    python3-dev

RUN pip install poetry

COPY . /app

WORKDIR /app

RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

EXPOSE 8000

CMD ["poetry", "run", "python", "core/manage.py", "runserver", "0.0.0.0:8000"]
