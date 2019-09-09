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

    # Контрагенты таблица
    def create_partner(self, data):
        sql = "INSERT INTO partner (name, surname, patronymic, company_name) VALUES (%s,%s,%s,%s,%s)"
        self.cursor.execute(sql, (data['name'], data['surname'], data['patronymic'], data['company_name']))
        self.connection.commit()

    def update_partner(self, data):
        sql = "UPDATE partner SET name=%s, surname=%s, patronymic=%s, company_name=%s WHERE company_name=%s"
        self.cursor.execute(sql, (
            data['name'], data['surname'], data['patronymic'], data['company_name'], data['old_company_name']))
        self.connection.commit()

    def delete_partner(self, data):
        sql = "DELETE FROM partner WHERE company_name=%s"
        self.cursor.execute(sql, (data['company_name']))
        self.connection.commit()

    def select_partners(self):
        partners = []
        sql = "SELECT * FROM partner"
        self.cursor.execute(sql)
        result = self.cursor.fetchall()
        for elem in result:
            partners.append({'Фамилия': elem[1], "Имя": elem[2], "Отчество": elem[3], "Компания": elem[4]})
        return partners

    # Продукты таблица
    def create_product(self, data):
        sql = "INSERT INTO product (name, purchase_price, selling_price) VALUES (%s,%s,%s)"
        self.cursor.execute(sql, (data['name'], data['purchase_price'], 'selling_price'))
        self.connection.commit()

    def update_product(self, data):
        sql = "UPDATE product SET name=%s, purchase_price=%s, selling_price=%s WHERE name=%s"
        self.cursor.execute(sql, (
            data['name'], data['purchase_price'], data['selling_price'], data['old_name']))
        self.connection.commit()

    def delete_product(self, data):
        sql = "DELETE FROM product WHERE name=%s"
        self.cursor.execute(sql, (data['name']))
        self.connection.commit()

    def select_products(self):
        products = []
        sql = "SELECT * FROM product"
        self.cursor.execute(sql)
        result = self.cursor.fetchall()
        for elem in result:
            products.append({'Имя': elem[1], "Остаток": elem[2], "Цена продажи": elem[3], "Цена покупки": elem[4]})
        return products

    def create_deal(self, data):
        sql = "INSERT INTO deal (partner_id, date, deal_type) VALUES ((SELECT id FROM partner WHERE company_name = " \
              "%s),%s,(SELECT id FROM deal_type WHERE value = %s))"
        self.cursor.execute(sql, (data['company_name'], data['date'], data['deal_type']))
        self.connection.commit()

        sql = "SELECT MAX(id) FROM deal"
        self.cursor.execute(sql)
        deal_id = self.cursor.fetchall()[0][0]

        for element in data['product']:
            sql = "INSERT INTO deal_product (deal_id, product_id, count) VALUES (%s, (SELECT id FROM product WHERE " \
                  "name= %s), %s)"
            self.cursor.execute(sql, (deal_id, element['name'], element['count']))
            self.connection.commit()

    def create_report(self, data):
        sql = "SELECT name, surname, patronymic FROM partner WHERE company_name=%s"
        self.cursor.execute(sql, (data['company_name'],))
        result = self.cursor.fetchall()
        name, surname, patronymic = result[0][0], result[0][1], result[0][2]

        sql = "SELECT id FROM deal WHERE partner_id = (SELECT id FROM partner WHERE company_name=%s) AND deal_type =" \
              " (SELECT id FROM deal_type WHERE value = 'Покупка') AND date BETWEEN %s AND %s"
        self.cursor.execute(sql, (data['company_name'], data['date_from'], data['date_to']))

        deal_ids = []
        for element in self.cursor.fetchall(): deal_ids.append(element[0])

        deals_info = []
        for deal_id in deal_ids:
            sql = "SELECT product_id, count FROM deal_product WHERE deal_id = %s"
            self.cursor.execute(sql, (deal_id,))
            for element in self.cursor.fetchall(): deals_info.append(
                {'Сделка': deal_id, 'Продукт': element[0], 'Количество': element[1]})

        for index, element in enumerate(deals_info):
            sql = "SELECT date FROM deal WHERE id = %s"
            self.cursor.execute(sql, (element['Сделка'],))
            deals_info[index]['Сделка'] = self.cursor.fetchall()[0][0].__str__()

            sql = "SELECT name FROM product WHERE id = %s"
            self.cursor.execute(sql, (element['Продукт'],))
            deals_info[index]['Продукт'] = self.cursor.fetchall()[0][0]

        report_info = {'Имя': name, 'Фамилия': surname, 'Отчество': patronymic, 'Инфомация о закупках': deals_info,
                       "Дата начала отсчета": data['date_from'], "Дата конца отсчета": data['date_to'],
                       "Компания": data['company_name']}

        return report_info
