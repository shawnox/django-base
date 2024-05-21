# Stage 1: Build stage
FROM python:3.11-alpine as builder

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    musl-dev \
    postgresql-dev \
    python3-dev

# Install Poetry
RUN pip install --upgrade pip \
    && pip install poetry

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install dependencies using Poetry
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Stage 2: Runtime stage
FROM python:3.11-alpine

# Install runtime dependencies
RUN apk add --no-cache \
    libffi \
    postgresql-libs

# Copy only the necessary files from the build stage
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /usr/local/bin/poetry /usr/local/bin/poetry
COPY --from=builder /app /app

# Set the working directory
WORKDIR /app

# Expose port 8000 (Django's default)
EXPOSE 8000

# Run the Django application
CMD ["poetry", "run", "python", "core/manage.py", "runserver", "0.0.0.0:8000"]
