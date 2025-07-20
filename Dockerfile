# Use official Python base image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    APP_HOME=/app

# Set working directory
WORKDIR $APP_HOME

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy project files into container
#COPY . $APP_HOME

# Install app and dependencies
#RUN pip install --upgrade pip && pip install .

COPY . .

# Install all requirements
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install -r requirements-base.txt && \
    pip install -r requirements-test.txt && \
    pip install .

# Copy the custom entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod 755 /app/entrypoint.sh

# Expose app port
EXPOSE 5000

# Default command: show CLI help
#CMD ["internet_application"]
ENTRYPOINT ["/app/entrypoint.sh"]
