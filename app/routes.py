from flask import render_template, request

from app import app
from app import worker


@app.route('/')
@app.route('/index')
def index():
    params = {"month_profit": worker.get_profit_by_month(),
              "profit": worker.get_profit_all_time(),
              "partners": worker.select_partners(),
              "products": worker.select_products(),
              "deals": worker.get_all_deals_info()}

    return render_template('index.html', params=params)


@app.route('/deal', methods=['POST'])
def deal():
    json = request.json
    print(json)

    params = {"month_profit": worker.get_profit_by_month(),
              "profit": worker.get_profit_all_time(),
              "partners": worker.select_partners(),
              "products": worker.select_products()}

    return render_template('index.html', params=params)


@app.route('/user', methods=['POST'])
def add_partner():
    pass
