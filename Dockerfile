FROM python:3.11-slim

WORKDIR /app

# Copy backend requirements and install
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend application
COPY backend/ ./backend/

# Copy the pre-built Flutter web app from the local machine build
COPY build/web/ ./backend/web_build/

# Set working directory to the backend so the python app finds web_build/ internally
WORKDIR /app/backend

# Expose the Cloud Run port
EXPOSE 8080

# Start the uvicorn server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
