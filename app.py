from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>Hello from Flask CI/CD App 🚀</h1><p>Running on local Ubuntu server.</p>"

@app.route("/about")
def about():
    return "<h2>About</h2><p>This app will be deployed later using AWS CI/CD.</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

