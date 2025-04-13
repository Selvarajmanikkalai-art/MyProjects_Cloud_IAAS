from flask import Flask, jsonify
import os
import psycopg2

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Backend!"

@app.route('/db')
def db_connect():
    try:
        conn = psycopg2.connect(
            host=os.environ.get("DB_HOST", "postgres"),
            dbname=os.environ.get("POSTGRES_DB", "mydb"),
            user=os.environ.get("POSTGRES_USER", "admin"),
            password=os.environ.get("POSTGRES_PASSWORD", "admin"),
        )
        return jsonify({"message": "Connected to database!"})
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
