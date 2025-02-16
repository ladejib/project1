from flask import Flask, render_template_string

app = Flask(__name__)

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
    return render_template_string(template, bg_color="lightblue")

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)

