from flask import render_template, request, Response
import datetime
from app import app
from app import worker
from app.utils import generate_report


@app.route('/')
@app.route('/index')
def index():
    params = {"month_profit": worker.get_profit_by_month(),
              "profit": worker.get_profit_all_time(),
              "partners": worker.select_partners(),
              "products": worker.select_products(),
              "deals": worker.get_all_deals_info(),
              "stocks": worker.get_stocks()}

    return render_template('index.html', params=params)


@app.route('/deal', methods=['POST'])
def deal():
    json = request.json
    json['date'] = datetime.datetime.now()
    worker.create_deal(json)
    return Response(status=200)


@app.route('/report', methods=['POST'])
def report():
    json = request.json
    rep_data = worker.create_report(json)
    generate_report(rep_data)
    return Response(status=200)


@app.route('/add_partner', methods=['POST'])
def add_partner():
    json = request.json
    worker.create_partner(json)
    return Response(status=200)


@app.route('/add_product', methods=['POST'])
def add_product():
    json = request.json
    worker.create_product(json)
    return Response(status=200)
