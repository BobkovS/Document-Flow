from flask import Flask
from datetime import datetime
from app.dblayer.manager import SqlWorker
from app.utils import generate_report
app = Flask(__name__)
worker = SqlWorker()

#data = {"product": [{"name": "Хлеб", "count": 10}, {"name": "Молоко", "count": 100}], "company_name": "Пятерочка",
#        "deal_type": "Покупка", "date": datetime.now()}

#worker.create_deal(data)

data = {'company_name': 'Пятерочка', 'date_from': '2019-08-01', 'date_to': '2019-09-10'}
result = worker.create_report(data)
generate_report(result)
#print(worker.get_schedule_all_time())

from app import routes
