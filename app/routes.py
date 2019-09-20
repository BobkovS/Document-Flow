import datetime
import json
from flask import render_template, request, send_from_directory, redirect, url_for
from verify_signature import verify_signature_temp
from app import app
from app import worker
from app.utils import *


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
    data = request.form
    data = data.to_dict()
    data['products'] = json.loads(data['products'])
    data['date'] = datetime.datetime.now()
    worker.create_deal(data)
    return redirect(url_for("index"))


@app.route('/report', methods=['POST'])
def report():
    data = request.form
    report_data = worker.create_report(data)
    generate_report(report_data)
    return send_from_directory('/home/bobkovs/PycharmProjects/Documents/', 'report.zip', as_attachment=True)


@app.route('/add_partner', methods=['POST'])
def add_partner():
    data = request.form
    worker.create_partner(data)
    return redirect(url_for('index'))


@app.route('/add_product', methods=['POST'])
def add_product():
    data = request.form.get('add_product_data')
    data = json.loads(data)
    worker.create_product(data)
    return redirect(url_for('index'))


@app.route('/check_sign', methods=['POST'])
def check_sign():
    request.files['document'].save('Отчет.docx')
    request.files['signature'].save('Подпись.txt')
    request.files['public_key'].save('Ключ.pem')
    result = verify_signature_temp()

    os.remove('Отчет.docx')
    os.remove('Подпись.txt')
    os.remove('Ключ.pem')

    return result
