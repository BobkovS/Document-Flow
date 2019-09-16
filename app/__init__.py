from flask import Flask
from datetime import datetime
from app.dblayer.manager import SqlWorker
from app.utils import generate_report
app = Flask(__name__)
worker = SqlWorker()


data = {'company_name': 'Пятерочка', 'date_from': '2019-08-01', 'date_to': '2019-09-10'}
result = worker.create_report(data)
generate_report(result)

from app import routes
