# Simple Flask app that prints FLAVOR env var
from flask import Flask
import os

app = Flask(__name__)

FLAVOR = os.environ.get("FLAVOR", "unset")

@app.route("/")
def index():
    return f"Hello from John! FLAVOR={FLAVOR}\n"
