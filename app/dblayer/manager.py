import psycopg2

from config import DB_USER, DB_PASSWORD, DB_NAME, DB_PORT, DB_HOST


class SqlWorker:
    def __init__(self):
        self.connection = psycopg2.connect(
            host=DB_HOST,
            port=DB_PORT,
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            target_session_attrs='read-write')
        self.cursor = self.connection.cursor()

    def create_partner(self, data):
        sql = "INSERT INTO partner (name, surname, patronymic, company_name) VALUES (%s,%s,%s,%s,%s)"
        self.cursor.execute(sql, (data['name'], data['surname'], data['patronymic'], data['company_name']))
        self.connection.commit()

    def update_partner(self, data):
        sql = "UPDATE partner SET name=%s, surname=%s, patronymic=%s, company_name=%s WHERE name=%s, surname=%s," \
              " patronymic=%s, company_name=%s"
        self.cursor.execute(sql, (
            data['name'], data['surname'], data['patronymic'], data['company_name'], data['old_name'],
            data['old_surname'], data['old_patronymic'], data['old_company_name']))
        self.connection.commit()

    def delete_partner(self, data):
        sql = "DELETE FROM partner WHERE name=%s, surname=%s, patronymic=%s, company_name=%s"
        self.cursor.execute(sql, (data['name'], data['surname'], data['patronymic'], data['company_name']))
        self.connection.commit()

    