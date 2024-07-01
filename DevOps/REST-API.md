# REST-API 

Creating web services that allow communication between client and server applications over HTTP using Python.



#### Simple programs
* basic example of a Flask application. `flask --app restapi run`
```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Hello, World!"
```


