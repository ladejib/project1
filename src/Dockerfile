# Use official Python image
FROM python:3.9-alpine
# Set the working directory inside the container
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
# Expose the Flask app port
EXPOSE 5000
CMD ["python", "app.py"]

