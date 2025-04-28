# Base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install required packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Install additional dependencies
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libtesseract-dev \
    libleptonica-dev \
    && rm -rf /var/lib/apt/lists/*

# Expose FastAPI app port
EXPOSE 8000

# Run the application
CMD ["uvicorn", "fastapi_chatbot_backend:app", "--host", "0.0.0.0", "--port", "8000"]
