
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

from config import Config

db = SQLAlchemy()

app = Flask(__name__)
app.config.from_object(Config)

db.init_app(app)


@app.route("/")
def home():
    return """
    <h1>Selamat Datang di KonsulIn</h1>
    <p>Sistem Informasi Pengajuan dan Penjadwalan Konsultasi Akademik.</p>
    """


@app.route("/cek-database")
def cek_database():
    try:
        with db.engine.connect() as connection:
            connection.execute(text("SELECT 1"))

        return "Koneksi database KonsulIn berhasil!"

    except Exception as error:
        return f"Koneksi database gagal: {error}", 500


if __name__ == "__main__":
    app.run(debug=True)
