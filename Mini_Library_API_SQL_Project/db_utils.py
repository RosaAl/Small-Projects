

import mysql.connector
from config import USER, PASSWORD, HOST


class DbConnectionError(Exception):
    pass


# To connect to the database.
def _connect_to_db(db_name):
    cnx = mysql.connector.connect(
        host=HOST,
        user=USER,
        password=PASSWORD,
        auth_plugin='mysql_native_password',
        database=db_name
    )
    return cnx



# To view the library.
def all_books():
    try:
        db_name = 'audiobook_library'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print('Connected!')
        query = """SELECT Book_ID, Name, Author, Genre, Stock_Availability
        FROM audiobooks
        ORDER BY Book_ID;"""
        cur.execute(query)
        data = cur.fetchall()
        for row in data:
            print(row)
        cur.close()
    except Exception:
        raise DbConnectionError('Fail')
    finally:
        if db_connection:
            db_connection.close()
            print('connection closed')
    return data




# To add a book to the database.
def add_book_data(record):
    try:
        db_name = 'audiobook_library'
        db_connection = _connect_to_db(db_name)
        cur = db_connection.cursor()
        print("Connected to DB:", record)

        query = """ INSERT INTO audiobooks (Name, Author, Genre, Stock_Availability)
                    VALUES (%s, %s, %s, %s)"""
        values = (record['Name'], record['Author'], record['Genre'], record['Stock_Availability'])
        cur.execute(query, values)
        db_connection.commit()
        cur.close()
    except Exception:
        raise DbConnectionError('fail')
    finally:
        if db_connection:
            db_connection.close()
            print('done!')








# To view available audiobooks
def book_availability():
    db_name = 'audiobook_library'
    db_connection = _connect_to_db(db_name)
    cur = db_connection.cursor()
    query = """
            SELECT Book_ID, Name, Author
            FROM audiobooks
            WHERE Stock_Availability >= 1
            ORDER BY Book_ID;
            """
    cur.execute(query)
    available_books = cur.fetchall()
    cur.close()
    db_connection.close()
    return available_books





# Function to call the CheckoutBook stored procedure
def checkout_book(customer_id, book_id):
    db_name = 'audiobook_library'
    db_connection = _connect_to_db(db_name)
    if db_connection:
        try:
            cursor = db_connection.cursor()
            cursor.callproc("CheckoutBook", (customer_id, book_id))
            for result in cursor.stored_results():
                print(result.fetchall())

            db_connection.commit()
            cursor.close()
        finally:
            db_connection.close()




# To view customer information
def customer_information():
    db_name = 'audiobook_library'
    db_connection = _connect_to_db(db_name)
    cur = db_connection.cursor()
    query = """ SELECT Customer_ID, Forename, Surname FROM customers ; """
    cur.execute(query)
    customer_inf = cur.fetchall()
    cur.close()
    db_connection.close()
    return customer_inf






