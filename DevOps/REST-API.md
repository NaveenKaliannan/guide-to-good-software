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


