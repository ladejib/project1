from flask import Flask, render_template_string
import logging
import sys, os

app = Flask(__name__)

# Ensure the logs directory exists
if not os.path.exists('/var/log'):
    os.makedirs('/var/log')

# Set up logging
log_file = '/var/log/app.log'

file_handler = logging.FileHandler(log_file)
file_handler.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s %(levelname)s %(name)s : %(message)s')
file_handler.setFormatter(formatter)

# Add the handler to the app's logger
app.logger.addHandler(file_handler)
app.logger.setLevel(logging.INFO)

template = """
<!DOCTYPE html>
<html>
<head>
    <title>Hello World Page</title>
    <style>
        body { background-color: {{ bg_color }}; text-align: center; font-family: Arial, sans-serif; }
        h1 { margin-top: 20%; }
    </style>
</head>
<body>
    <h1>Hello, World!</h1>
</body>
</html>
"""

@app.route("/")
def home():
    app.logger.info('Home endpoint was accessed')
    return render_template_string(template, bg_color="lightblue")

@app.route('/error')
def error():
    app.logger.error('Error endpoint triggered')
    return render_template_string(template, bg_color="red")

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)

