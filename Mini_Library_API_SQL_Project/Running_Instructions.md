### <ins>Mini Audiobook Library Information</ins>

For this project I have created a database API for a mini online audiobook library.<br>It has the functionality to be a **librarian or customer**.<br>As a librarian you can view and/or add a new book. As a customer you can view and/or checkout a book.<br>
Due to being a mini-library the stock so far as 1 copy of each book available, those with 0 are already checked out.


In the project folder please find all the scripts required to run.

<ins>Step 1:</ins><br>
To successfully run the script please first ensure you have the following installed on your computer via the terminal/command line:
- pip install requests
- pip install flask
- pip install mysql-connector-python

<br><ins>Step 2:</ins><br>
Once installed please run the Assignment4SQLScript in your MySQL platform.
Please ensure you run and call the procedure.

<ins>Step 3:</ins><br>
Open the config.py file and insert your specific MySQL HOST, USER and PASSWORD details.

<ins>Step 4:</ins><br>
Open the app.py file. In your terminal locate the files on your computer and switch to the correct folder using "cd FOLDER NAME".<br>
When in the folder, connect to the API using "python app.py."<br>
At this stage would be a good opportunity to test the GET endpoints to ensure the connection is working and utilise the error handling.

<ins>Step 5:</ins><br>
Once the API is running please open a new tab and connect to the client-side script with <python3 main.py>.
You will now be able to run the API!
<br>
<br>