from flask import Flask
from app.dblayer.manager import SqlWorker
app = Flask(__name__)
worker = SqlWorker()
from app import routes
