import random
from pathlib import Path
from flask import Flask, jsonify

def load_quotes():
    with Path("data/quotes.txt").open() as fh:
        return [line.strip() for line in fh if line.strip()]

QUOTES = load_quotes()
app = Flask(__name__)

@app.get("/quote")
def quote():
    return jsonify({"quote": random.choice(QUOTES)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
