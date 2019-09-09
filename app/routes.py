from flask import render_template

from app import app
from app import worker


@app.route('/')
@app.route('/index')
def index():
    return render_template('index.html')


@app.route('/user', methods=['GET'])
def get_partners():
    partners = worker.select_partners()


@app.route('/user', methods=['POST'])
def add_partner():
    pass
