import re
from urllib.parse import urlparse, parse_qs
import psycopg2


def read(file):
    """Парсинг лог-файла."""
    regexp = r"^.*?(?P<datetime>\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}).*?" \
                  r"(?P<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}).*?(?P<url>http.*)$"

    parsed_logs = []
    pattern = re.compile(regexp)
    with open(file, 'r') as f:
        for line in f:
            data = pattern.match(line)
            extracted_url = data.group('url')
            parsed_url = urlparse(extracted_url)
            query_params = parse_qs(parsed_url.query)
            query_params = {param: value[0] for param, value in query_params.items()}
            parsed_logs.append([data.group('datetime'), data.group('ip'), parsed_url.path, query_params])
    return parsed_logs


def write(parsed_logs):
    """Подготовка данных и запись в базу."""
    con = psycopg2.connect(
        database="fish_db",
        user="aattrr",
        password="q",
        host="127.0.0.1",
        port="5432"
    )
    print("Database opened successfully")
    cur = con.cursor()
    for item in parsed_logs:
        datetime, ip, path, params = item

        user_id = params.get('user_id')
        goods_id = params.get('goods_id')
        amount = params.get('amount')
        cart_id = params.get('cart_id')

        cur.execute(
            'INSERT INTO parsed_log (ip, date_time, product_id, cart_id, url, amount, customer_id) '
            'VALUES (%s, %s, %s, %s, %s, %s, %s)',
            (ip, datetime, goods_id, cart_id, path, amount, user_id)
        )
    con.commit()
    con.close()
    print("Database closed")


if __name__ == '__main__':
    write(read('logs.txt'))
