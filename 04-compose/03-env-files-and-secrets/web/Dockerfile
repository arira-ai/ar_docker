# Simple Flask app container
FROM python:3.11-alpine

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY app.py .

# Expose port and run
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]
