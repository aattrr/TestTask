PGDMP         .                y            fish_db    13.0    13.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24659    fish_db    DATABASE     d   CREATE DATABASE fish_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE fish_db;
                postgres    false            �            1259    24695    cart    TABLE     |   CREATE TABLE public.cart (
    id integer NOT NULL,
    ip character varying(15) NOT NULL,
    is_paid integer DEFAULT 0
);
    DROP TABLE public.cart;
       public         heap    postgres    false            �            1259    24706    cart_product    TABLE     �   CREATE TABLE public.cart_product (
    id integer NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    amount integer DEFAULT 1 NOT NULL
);
     DROP TABLE public.cart_product;
       public         heap    postgres    false            �            1259    24670    customer    TABLE     H   CREATE TABLE public.customer (
    ip character varying(15) NOT NULL
);
    DROP TABLE public.customer;
       public         heap    postgres    false            �            1259    24680    customer_transaction    TABLE     �   CREATE TABLE public.customer_transaction (
    id integer NOT NULL,
    produc_id integer NOT NULL,
    ip character varying(15) NOT NULL,
    date_time timestamp without time zone NOT NULL,
    action_type character varying(30)
);
 (   DROP TABLE public.customer_transaction;
       public         heap    postgres    false            �            1259    24770 
   parsed_log    TABLE       CREATE TABLE public.parsed_log (
    id integer NOT NULL,
    ip character varying(15) NOT NULL,
    url character varying(255),
    date_time timestamp without time zone NOT NULL,
    product_id integer,
    cart_id integer,
    amount integer,
    customer_id bigint
);
    DROP TABLE public.parsed_log;
       public         heap    postgres    false            �            1259    24768    parsed_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.parsed_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.parsed_log_id_seq;
       public          postgres    false    206            �           0    0    parsed_log_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.parsed_log_id_seq OWNED BY public.parsed_log.id;
          public          postgres    false    205            �            1259    24665    product    TABLE     �   CREATE TABLE public.product (
    id integer NOT NULL,
    product_name character varying(100),
    product_category character varying(100) NOT NULL
);
    DROP TABLE public.product;
       public         heap    postgres    false            8           2604    24773    parsed_log id    DEFAULT     n   ALTER TABLE ONLY public.parsed_log ALTER COLUMN id SET DEFAULT nextval('public.parsed_log_id_seq'::regclass);
 <   ALTER TABLE public.parsed_log ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    206    206            �          0    24695    cart 
   TABLE DATA           /   COPY public.cart (id, ip, is_paid) FROM stdin;
    public          postgres    false    203   �"       �          0    24706    cart_product 
   TABLE DATA           G   COPY public.cart_product (id, cart_id, product_id, amount) FROM stdin;
    public          postgres    false    204   �"       �          0    24670    customer 
   TABLE DATA           &   COPY public.customer (ip) FROM stdin;
    public          postgres    false    201   �"       �          0    24680    customer_transaction 
   TABLE DATA           Y   COPY public.customer_transaction (id, produc_id, ip, date_time, action_type) FROM stdin;
    public          postgres    false    202   �"       �          0    24770 
   parsed_log 
   TABLE DATA           f   COPY public.parsed_log (id, ip, url, date_time, product_id, cart_id, amount, customer_id) FROM stdin;
    public          postgres    false    206   �"       �          0    24665    product 
   TABLE DATA           E   COPY public.product (id, product_name, product_category) FROM stdin;
    public          postgres    false    200   #       �           0    0    parsed_log_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.parsed_log_id_seq', 72852, true);
          public          postgres    false    205            @           2606    24700    cart cart_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_pkey;
       public            postgres    false    203            B           2606    24711    cart_product cart_product_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.cart_product
    ADD CONSTRAINT cart_product_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.cart_product DROP CONSTRAINT cart_product_pkey;
       public            postgres    false    204            <           2606    24674    customer customer_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (ip);
 @   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
       public            postgres    false    201            >           2606    24684 .   customer_transaction customer_transaction_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.customer_transaction
    ADD CONSTRAINT customer_transaction_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.customer_transaction DROP CONSTRAINT customer_transaction_pkey;
       public            postgres    false    202            :           2606    24669    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    200            E           2606    24701    cart cart_ip_fkey    FK CONSTRAINT     n   ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_ip_fkey FOREIGN KEY (ip) REFERENCES public.customer(ip);
 ;   ALTER TABLE ONLY public.cart DROP CONSTRAINT cart_ip_fkey;
       public          postgres    false    2876    203    201            F           2606    24712 &   cart_product cart_product_cart_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_product
    ADD CONSTRAINT cart_product_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.cart(id);
 P   ALTER TABLE ONLY public.cart_product DROP CONSTRAINT cart_product_cart_id_fkey;
       public          postgres    false    204    203    2880            G           2606    24717 )   cart_product cart_product_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.cart_product
    ADD CONSTRAINT cart_product_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product(id);
 S   ALTER TABLE ONLY public.cart_product DROP CONSTRAINT cart_product_product_id_fkey;
       public          postgres    false    204    2874    200            D           2606    24690 1   customer_transaction customer_transaction_ip_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.customer_transaction
    ADD CONSTRAINT customer_transaction_ip_fkey FOREIGN KEY (ip) REFERENCES public.customer(ip);
 [   ALTER TABLE ONLY public.customer_transaction DROP CONSTRAINT customer_transaction_ip_fkey;
       public          postgres    false    201    202    2876            C           2606    24685 8   customer_transaction customer_transaction_produc_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.customer_transaction
    ADD CONSTRAINT customer_transaction_produc_id_fkey FOREIGN KEY (produc_id) REFERENCES public.product(id);
 b   ALTER TABLE ONLY public.customer_transaction DROP CONSTRAINT customer_transaction_produc_id_fkey;
       public          postgres    false    202    200    2874            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �     