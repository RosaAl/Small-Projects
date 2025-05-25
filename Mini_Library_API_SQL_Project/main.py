
# This is the client side.

import requests
import json
import pprint
from db_utils import checkout_book

# Before the script, please find below all the functions that will be called.

# To view all books.
def view_all_information():
    res = (requests.get('http://127.0.0.1:5000/audiobooks')).json()
    return res
# print(*view_all_information()) #if you want to view this information without the rest of the script


# Adding a new book to the library.
def add_new_book():
    name = input("Enter the book name: ")
    author = input("Enter the author's name: ")
    genre = input("Enter the genre: ")
    stock = input("Enter stock amount: ")
    new_book = {
        "Name": name,
        "Author": author,
        "Genre": genre,
        "Stock_Availability": stock
    }
    try:
        result = requests.post(
            'http://127.0.0.1:5000/adding_book', headers={'content-type': 'application/json'}, data=json.dumps(new_book)
        )
        # print(f"Response Status Code: {result.status_code}") #can uncomment these two lines if you would like them to be included in the client-view, useful if errors.
        # print(f"Response Data: {result.text}")
        print("\n\nThe new audiobook has been added, please find below updated library:\n")
        pprint.pprint(view_all_information())
        print("\nSee you soon!")
        return result
    except requests.exceptions.RequestException as i:
        print(f"An error occurred: {i}")
        return None


# To view available audiobooks.
def check_availability():
    result = (requests.get('http://127.0.0.1:5000/audiobooks/available')).json()
    return result


# To view customer information.
def check_customer_id():
    find_cust_id = input("Do you know your Customer ID? y/n ")
    know_id = find_cust_id == 'y'
    if know_id:
        book_checkout()
        print("Thank you for checking out an audiobook, please return the resource in 15 days. Please come back soon!")
        quit()
    else:
        print("\nPlease find your ID from the list below. Please note, if you are not registered you will need to contact a Librarian.")
        result = (requests.get('http://127.0.0.1:5000/customers')).json()
        pprint.pp(result)
        find_cust = input("\nDid you find your Customer ID? y/n ")
        is_cust = find_cust == 'y'
        if is_cust:
            book_checkout()
            print("Thank you for checking out an audiobook, please return the resource in 15 days. Please come back soon!")
            quit()
        else:
            print("\nNo problem! Please return to the audiobook library soon!")
            quit()


# To checkout a book.
def book_checkout():
    try:
        customer_id = int(input("Enter Customer ID: "))
        book_id = int(input("Enter Book ID to check out: "))

        print("\nProcessing checkout...\n")
        checkout_book(customer_id, book_id)

    except ValueError:
        print("Invalid input. Please enter numeric values for IDs.")


# This will query with the customer if they would like to start the book checkout process.
def question_checkout_book():
    checkout_question_ = input("\nWould you like to checkout an audiobook? y/n ")
    checkout_ = checkout_question_ == 'y'
    if checkout_:
        check_customer_id()
    else:
        print("\nNo problem! Please return to the audiobook library soon!")
        quit()
    return question_checkout_book()





# This is the main running script. I have tried to make it as readable as possible using the functions above.
# Please note the admin password for the librarian is "Bookworm". Decided not to make this editable as it is usually shared between a group of employees.

def run():
    admin_or_cust = input("Hello, welcome to the Mini Audiobook Library. Please confirm whether you are a Librarian or Customer: ")

    admin = admin_or_cust == "Librarian"
    cust = admin_or_cust == "Customer"

    if admin:
        password = input("Please insert the admin password: ")
        admin_password = password == "Bookworm"

        if admin_password:
            admin_question = input("Please type 'a' to view all books, or 'b' to add a new book: ")
            view_books = admin_question == "a"

            if view_books:
                print("\nBook ID, Title, Author, Stock Amount")
                pprint.pprint(view_all_information())
                add_yes = input("\nWould you like to add a new book? y/n ")
                add_book = add_yes == 'y'

                if add_book:
                    add_new_book()
                    quit()
                else:
                    print("\nSee you next time!")
                    quit()

            else:
                add_new_book()
                quit()

        else:
            print("Access Denied! Please start again.")
            quit()



    if cust:
        cust_question = input("\nWelcome to the Library, Please type 'a' to view all books, or 'b' to see items available to rent only: ")
        view_books = cust_question == "a"

        if view_books:
            print("\nBook ID, Title, Author, Stock Amount")
            pprint.pprint(view_all_information())
            question_checkout_book()
        else:
            print("\nBook ID, Title, Author")
            pprint.pprint(check_availability())
            question_checkout_book()

    else:
        print("Input not recognised, please refresh program.")






if __name__ == '__main__':
    run()






