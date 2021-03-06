CREATE TABLE customer (
    id bigint PRIMARY KEY,
    ip varchar(15) NOT NULL,
    first_name varchar(50) NOT NULL,
    second_name varchar(100) NOT NULL,
    phone varchar(12) NOT NULL);

	
CREATE TABLE product (
    id integer PRIMARY KEY,
    product_name varchar(100) NOT NULL,
    product_category varchar(100) NOT NULL);

	
CREATE TABLE cart (
    id integer PRIMARY KEY,
    customer_id bigint NOT NULL,
    is_paid integer default 0,
    FOREIGN KEY (customer_id) REFERENCES customer(id));


CREATE TABLE cart_product (
    id integer PRIMARY KEY,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer default 1,
    FOREIGN KEY (cart_id) REFERENCES cart(id),
    FOREIGN KEY (product_id) REFERENCES product(id));

	
CREATE TABLE customer_transaction (
    id integer PRIMARY KEY,
    customer_id bigint NOT NULL,
    product_id integer NOT NULL,
    cart_id integer NOT NULL,
    date_time timestamp  NOT NULL,
    action_type varchar(30),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (cart_id) REFERENCES cart(id));
	
	
CREATE TABLE parsed_log (
    id SERIAL,
    ip varchar(15) NOT NULL,
    date_time timestamp NOT NULL,
    product_id integer,
    cart_id integer,
    url varchar(255),
    amount integer,
    customer_id bigint);
	