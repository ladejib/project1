# Use official Python image
FROM python:3.9-alpine as builder
# Set the working directory inside the container
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.9-alpine
WORKDIR /app
COPY --from=builder /app .
COPY . .
# Expose the Flask app port
EXPOSE 5000
CMD ["python", "app.py"]

