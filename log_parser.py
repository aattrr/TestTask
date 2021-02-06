import re
import csv
from urllib.parse import urlparse, parse_qsl, parse_qs
import psycopg2


def reader(file):
    '''Парсинг лог-файла'''

    # формируем регулярное выражение
    regexp = r"^.*?(?P<datetime>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}).*?" \
                  r"(?P<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*?(?P<url>http.*)$"

    # инициализируем список в котором будут содержаться извлечённые из лог-файла данные
    data_list = []
    # Компилируем объект регулярного выражения для последующего использования
    pattern = re.compile(regexp)
    with open(file, 'r') as f:
        for line in f:
            # ищем по заданному шаблону
            data = pattern.match(line)
            # извлекаем из url параметры помещая их в словарь
            extracted_url = data.group('url')
            parsed_url = urlparse('{}'.format(extracted_url))

            k_dict = parse_qs(parsed_url.query)
            data_list.append([data.group('datetime'), data.group('ip'), k_dict])

    return data_list


def write(data_list):
    '''Подготовка данных и запись в базу'''
    # Подключаемся к БД
    con = psycopg2.connect(
        database="fish_db",
        user="aattrr",
        password="q",
        host="127.0.0.1",
        port="5432"
    )
    print("Database opened successfully")

    cur = con.cursor()

    for item in data_list:
        if item[2].get('user_id'):
            user_id = item[2]['user_id'][0]
        else:
            user_id = None

        if item[2].get('goods_id'):
            goods_id = item[2]['goods_id'][0]
        else:
            goods_id = None

        if item[2].get('amount'):
            amount = item[2]['amount'][0]
        else:
            amount = None

        if item[2].get('cart_id'):
            cart_id = item[2]['cart_id'][0]
        else:
            cart_id = None

        cur.execute(
            'INSERT INTO parsed_log (date_time, ip, product_id, amount, cart_id, customer_id) '
            'VALUES (%s, %s, %s, %s, %s, %s)',
            (item[0], item[1], goods_id, amount, cart_id, user_id)
        )

    con.commit()
    con.close()
    print("Database closed")


if __name__ == '__main__':
    write(reader('logs.txt'))
