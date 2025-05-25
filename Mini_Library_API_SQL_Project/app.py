

# This is the server side. Before running the script please ensure you have installed the relevant packages as per the MD instructions.

from flask import Flask, jsonify, request
from db_utils import all_books, add_book_data, book_availability, checkout_book, customer_information


app = Flask(__name__)


# The below will simply confirm the connection.
@app.route('/')
def index():
    return "The Mini Audiobook Library API is connected!"
# http://127.0.0.1:5000


# To view all records.
@app.route('/audiobooks', methods=['GET'])
def all_records():
    res = all_books()
    return jsonify(res)
# http://127.0.0.1:5000/audiobooks


# To add a new book through the POST method.
@app.route('/adding_book', methods=['POST'])
def add_new_book():
    adding_book = request.get_json()
    add_book_data(adding_book)
    return jsonify({"message": "Book added successfully!", "book": adding_book}), 201


# To view audiobooks what are available to rent.
@app.route('/audiobooks/available', methods=['GET'])
def available():
    result = book_availability()
    return jsonify(result)
# http://127.0.0.1:5000/audiobooks/available


# To checkout a book.
@app.route('/checkout', methods=['POST'])
def checkout():
    try:
        data = request.json
        customer_id = data.get("customer_id")
        book_id = data.get("book_id")

        if not customer_id or not book_id:
            return jsonify({"error": "Missing customer_id or book_id"}), 400

        checkout_book(customer_id, book_id)
        return jsonify({"message": "Book checkout processed successfully!"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# To view all customer information.
@app.route('/customers', methods=['GET'])
def customers():
    result = customer_information()
    return jsonify(result)
# http://127.0.0.1:5000/customers


if __name__ == '__main__':
    app.run(debug=True)