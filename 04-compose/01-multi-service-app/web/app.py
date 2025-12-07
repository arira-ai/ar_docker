# Simple Flask app showing DB connectivity
from flask import Flask
import os
import psycopg2
from psycopg2 import sql, OperationalError

app = Flask(__name__)

DB_URL = os.environ.get("DATABASE_URL", "postgresql://john:pass123@db:5432/demo")

def get_db_version():
    try:
        conn = psycopg2.connect(DB_URL, connect_timeout=3)
        cur = conn.cursor()
        cur.execute("SELECT version();")
        result = cur.fetchone()
        cur.close()
        conn.close()
        return result[0] if result else "unknown"
    except OperationalError as e:
        return f"DB connection failed: {e}"

@app.route("/")
def index():
    db_ver = get_db_version()
    return f"Hello from John! DB: {db_ver}\n"
