# REST-API 

Creating web services that allow communication between client and server applications over HTTP using Python.

### functions
* **@app.route() and @app.get()** are functionally the same for GET requests, the choice between them often comes down to personal. For APIs, the method-specific decorators (@app.get(), @app.post(), etc.) can improve readability. GET request (type the URL (web address) of that specific page into your web browser's address bar and press Enter) is a way for your web browser to ask the website's server for a specific piece of information or resource.



#### Simple programs
* Basic example of a Flask application. `flask --app app run`. Service is accessed via `http://127.0.0.1:5000/`.
```python
#app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Hello, World!"
```
* Store. Service is accessed via `http://127.0.0.1:5000/store`. 
```python
from flask import Flask, jsonify

app = Flask(__name__)

stores = [{"name": "chair", "price": 100}]

@app.route("/store", methods=['GET'])
def get_stores():
    return jsonify({"stores": stores})

if __name__ == "__main__":
    app.run(debug=True)
``` 
* A simple program to understand all the endpoints in Rest API. `GET /books` - Retrieves all books , `GET /books/<id>` - Retrieves a specific book by ID, `POST /books` - Adds a new book, `PUT /books/<id>` - Updates an existing book. `DELETE /books/<id>` - Deletes a book.

Browser doesnt allow one to delete or add content, hence curl can be used like for delete `curl -X DELETE http://127.0.0.1:5000/books/1` or for post `curl -X POST -H "Content-Type: application/json" -d '{"title": "New Book", "author": "John Doe"}' http://127.0.0.1:5000/books` or for put `curl -X PUT -H "Content-Type: application/json" -d '{"title": "Updated Book Title", "author": "Jane Doe"}' http://127.0.0.1:5000/books/1`
```python
from flask import Flask, request, jsonify

app = Flask(__name__)

# Our simple "database" of books
books = [
    {"id": 1, "title": "To Kill a Mockingbird", "author": "Harper Lee"},
    {"id": 2, "title": "1984", "author": "George Orwell"}
]

# GET - Retrieve all books
@app.route('/books', methods=['GET'])
def get_books():
    return jsonify(books)

# GET - Retrieve a specific book by ID
@app.route('/books/<int:book_id>', methods=['GET'])
def get_book(book_id):
    book = next((book for book in books if book['id'] == book_id), None)
    if book:
        return jsonify(book)
    return jsonify({"error": "Book not found"}), 404

# POST - Add a new book
@app.route('/books', methods=['POST'])
def add_book():
    new_book = request.json
    new_book['id'] = len(books) + 1
    books.append(new_book)
    return jsonify(new_book), 201

# PUT - Update a book
@app.route('/books/<int:book_id>', methods=['PUT'])
def update_book(book_id):
    book = next((book for book in books if book['id'] == book_id), None)
    if book:
        book.update(request.json)
        return jsonify(book)
    return jsonify({"error": "Book not found"}), 404

# DELETE - Remove a book
@app.route('/books/<int:book_id>', methods=['DELETE'])
def delete_book(book_id):
    global books
    books = [book for book in books if book['id'] != book_id]
    return '', 204

if __name__ == '__main__':
    app.run(debug=True)
```


