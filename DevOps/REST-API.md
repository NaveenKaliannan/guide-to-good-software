# REST-API 

Web API between applications. 

### How to interact in Rest APIs
* Via Curl command. The curl command is a versatile command-line tool used for transferring data to and from servers using various protocols.  It supports many protocols including HTTP, HTTPS, FTP, SFTP, SCP, TELNET, and more. Key features: Can send HTTP requests (GET, POST, PUT, DELETE, etc.). Supports sending custom headers and data. Can handle cookies and authentication. Allows downloading files Supports proxy servers. Can follow redirects.
```bash
curl -O https://example.com/file.zip # Download a file
curl -X POST -d "data" https://api.example.com #Send a POST request
curl -I https://example.com # Get headers only
```
* HTTPS (Hypertext Transfer Protocol Secure) and HTTP (Hypertext Transfer Protocol) used for transferring data over the internet.
  1.  HTTP is the standard protocol used for transmitting data over the web. It is an unsecured protocol, which means that the data transmitted between the client (e.g., a web browser) and the server is not encrypted. This makes the data vulnerable to interception and potential tampering by third parties. HTTP uses port 80 by default. 
  2.   HTTPS is the secure version of HTTP. It uses SSL (Secure Sockets Layer) or TLS (Transport Layer Security) to encrypt the data transmitted between the client and the server. This ensures that the data remains secure and protected from unauthorized access or tampering. HTTPS is commonly used for sensitive information, such as login credentials, credit card numbers, and other personal data. HTTPS uses port 443 by default.
  3. The main differences between HTTP and HTTPS are: **Security**: HTTPS provides a secure and encrypted connection, while HTTP is an unsecured protocol. **Encryption**: HTTPS encrypts the data transmitted between the client and the server, while HTTP does not. **Port**: HTTP uses port 80, while HTTPS uses port 443. Padlock icon: In web browsers, HTTPS websites are typically indicated by a padlock icon in the address bar, signifying a secure connection.
  4. There are many possible values for the HTTP Content-Type header, as it can specify a wide variety of media types and subtypes. Some of the most common Content-Type values include: `text/html` - for HTML documents. `text/plain` - for plain text. `image/jpeg` - for JPEG images. `image/png` - for PNG images. `application/json` - for JSON data. `application/pdf` - for PDF documents. `audio/mpeg` - for MP3 audio. video/mp4 - for MP4 video
*  How to run flask `flask --app app --debug --env production run --host=0.0.0.0 --port=8000`
*  Docker services `docker build -t flask-simple-app .` and `docker run -p 7000:8000 flask-app`
```Dockerfile
FROM python:3.10

# Set the working directory to /app
WORKDIR /app

# Install Flask
RUN pip install flask

# Copy the app.py file into the container
COPY app.py .

# Expose the port
EXPOSE 8000

# Set the FLASK_APP environment variable
ENV FLASK_APP=app.py

# Run the Flask app
CMD ["flask", "run", "--debug", "--host=0.0.0.0", "--port=8000"]
```
```yaml
version: '3'

services:
  web:
    build: .
    ports:
      - "5000:8000"
    environment:
      - FLASK_APP=app.py
      - FLASK_ENV=development
    volumes:
      - .:/app
```





### functions
* **@app.route() and @app.get()** are functionally the same for GET requests, the choice between them often comes down to personal. For APIs, the method-specific decorators (@app.get(), @app.post(), etc.) can improve readability. GET request (type the URL (web address) of that specific page into your web browser's address bar and press Enter) is a way for your web browser to ask the website's server for a specific piece of information or resource.
* **request.get_json()**  and **request.json** are used to access the request body as JSON in Flask, **request.get_json()** offers more control over the parsing process through its optional parameters. It accepts optional parameters to control the behavior, such as force=True to parse the request even if the content-type is not application/json, or silent=True to return None instead of raising an exception on parsing failure.
```python
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/example', methods=['POST'])
def example():
    # Example 1: Using force=True
    data = request.get_json(force=True)
    if data:
        return jsonify({"message": "Data received", "data": data})
    else:
        return jsonify({"error": "Invalid JSON data"}), 400

@app.route('/example2', methods=['POST'])
def example2():
    # Example 2: Using silent=True
    data = request.get_json(silent=True)
    if data:
        return jsonify({"message": "Data received", "data": data})
    else:
        return jsonify({"error": "Invalid JSON data"}), 400

if __name__ == '__main__':
    app.run(debug=True)
```
```bash
# Example 1: Using force=True
curl -X POST -H "Content-Type: text/plain" -d '{"name": "John", "age": 30}' http://localhost:5000/example

# Example 2: Using silent=True
curl -X POST -H "Content-Type: text/plain" -d '{"name": "Jane", "age": 25}' http://localhost:5000/example2

# Even though the content-type is set to text/plain, force=True allows Flask to parse the request body as JSON. In the second example, silent=True prevents Flask from raising an exception if the parsing fails
```


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


