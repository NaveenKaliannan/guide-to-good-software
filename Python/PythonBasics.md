# Python

### Virtual 
To set up a virtual environment for pip installations on Debian Linux, follow these steps:
```sh
sudo apt install python3 python3-venv
python3 -m venv /path/to/your/virtual/environment
source /path/to/your/virtual/environment/bin/activate
deactivate
```
Copy the file in bashrc
```bash
# Function to create a virtual environment
function mkvenv() {
    if [ -z "$1" ]; then
        echo "Usage: mkvenv <env_name>"
    else
        python3 -m venv "$1"
        echo "Virtual environment '$1' created."
    fi
}

# Function to activate a virtual environment
function actvenv() {
    if [ -z "$1" ]; then
        echo "Usage: actvenv <env_name>"
    else
        source "$1/bin/activate"
        echo "Virtual environment '$1' activated."
    fi
}

# Function to deactivate the current virtual environment
function deactvenv() {
    deactivate
    echo "Virtual environment deactivated."
}
```

### Variables - Name for a value in python
Python evaluates the right side of the assignment first. When variable y=2 and x=y then both variables refer to the same value. 
* **Weak and Strong references** Strong references are the default in Python. They keep objects alive in memory as long as at least one strong reference exists. Weak References create more memory-efficient programs that allow the garbage collector to reclaim memory when objects are no longer
```python
import weakref
import gc

class MyObject:
    def __init__(self, name):
        self.name = name
    
    def __repr__(self):
        return f"MyObject({self.name})"

def demonstrate_references():
    # Create objects
    obj1 = MyObject("Strong")
    obj2 = MyObject("Weak")

    # Create a strong reference
    strong_ref = obj1

    # Create a weak reference
    weak_ref = weakref.ref(obj2)

    print("Initial state:")
    print(f"Strong ref: {strong_ref}")
    print(f"Weak ref: {weak_ref()}")

    # Delete original references
    del obj1
    del obj2

    # Force garbage collection
    gc.collect()

    print("\nAfter deleting original references and garbage collection:")
    print(f"Strong ref: {strong_ref}")
    print(f"Weak ref: {weak_ref()}")

    # Delete strong reference
    del strong_ref
    gc.collect()

    print("\nAfter deleting strong reference:")
    print(f"Weak ref: {weak_ref()}")

demonstrate_references()

```
* **Integer (int)** x = 5 Whole numbers without decimal points
```python
y = 2  # It creates an integer object with the value 2.  and  It assigns the variable y to refer to this object.
x = y # Python evaluates the right side (y) first. It sees that y refers to the integer object with value 2. It then assigns x to refer to the same object.
x = 10
print(id(x))  # Output: 1402950320 (or some other unique identifier) This identifier is an integer that is guaranteed to be unique and constant for a specific object during its lifetime. It can be used to identify objects and distinguish them from one another
``` 
* **Float** y = 3.14 Numbers with decimal points
```python
number = 3.14159
print(f"{number:.2f}")  # Prints: 3.14
print(f"{number:.4f}")  # Prints: 3.1416
print("{:.2f}".format(number))  # Prints: 3.14
print("%.2f" % number)  # Prints: 3.14
print(round(number, 2))  # Prints: 3.14
``` 
* **String (str)** name = "Alice" Sequence of characters
```
vorname = "Naveen"
nachname = "Kaliannan"
fullname = vorname + " " + nachname
fullname_fstring = f"{vorname} {nachname}" # F-strings (formatted string literals) in Python provide a concise and readable way to embed expressions inside string literals
print(fullname, fullname_fstring)
vorname = "Naveen Kumar"
print(fullname, fullname_fstring)

# Using the .format() method for string formatting
fullnameformat = "{} {}"
fullname_format = fullnameformat.format("Naveen Kumar", "Kaliannan")
print(fullname_format)
``` 
* **Boolean (bool)** is_active = True Represents True or False
```
# Boolean values
x = True
y = False

# Comparison operations
print("Comparison operations:")
print("5 > 3:", 5 > 3)
print("10 == 9:", 10 == 9)

# Logical operators
print("\nLogical operators:")
print("True and False:", True and False)
print("True or False:", True or False)
print("not True:", not True)

# Boolean conversion using bool()
print("\nBoolean conversion:")
print("bool(1):", bool(1))
print("bool(0):", bool(0))
print("bool(\"\"):", bool(""))
print("bool(\"Hello\"):", bool("Hello"))

# Additional examples
print("\nAdditional examples:")
print("x or y:", x or y)
print("x and y:", x and y)
print("bool([]):", bool([]))
print("bool([1, 2, 3]):", bool([1, 2, 3]))
print("5 <= 5:", 5 <= 5)
print("'a' in 'apple':", 'a' in 'apple')
``` 
* **Complex** z = 3 + 4j Numbers with real and imaginary parts
* **Sequence Types List** fruits = ["apple", "banana", "cherry"] Ordered, mutable collection of items
```python
fruits = ["apple", "banana"]
fruits.append("cherry")  # Modifies the original list
print(fruits)  # Output: ["apple", "banana", "cherry"]

# Basic list comprehension
numbers = [1, 2, 3, 4, 5]
squares = [x**2 for x in numbers]
print("Squares:", squares)

# List comprehension with condition
even_squares = [x**2 for x in numbers if x % 2 == 0]
print("Even squares:", even_squares)

# Nested list comprehension
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
flattened = [num for row in matrix for num in row]
print("Flattened matrix:", flattened)

# List comprehension with string manipulation
words = ["hello", "world", "python", "programming"]
upper_words = [word.upper() for word in words]
print("Uppercase words:", upper_words)

# List comprehension with conditional expression (ternary operator)
numbers = [-4, -2, 0, 2, 4]
abs_values = [x if x >= 0 else -x for x in numbers]
print("Absolute values:", abs_values)

# List comprehension with enumerate
indexed_words = [(index, word) for index, word in enumerate(words)]
print("Indexed words:", indexed_words)

# List comprehension with zip
list1 = [1, 2, 3]
list2 = ['a', 'b', 'c']
paired = [(x, y) for x, y in zip(list1, list2)]
print("Paired lists:", paired)

# List comprehension with dictionary
dict1 = {'a': 1, 'b': 2, 'c': 3}
swapped = [(v, k) for k, v in dict1.items()]
print("Swapped dict:", swapped)

# Nested list comprehension for matrix transposition
transposed = [[row[i] for row in matrix] for i in range(3)]
print("Transposed matrix:", transposed)

# List comprehension with set comprehension
unique_lengths = {len(word) for word in words}
print("Unique word lengths:", unique_lengths)

# List comprehension with dictionary comprehension
word_lengths = {word: len(word) for word in words}
print("Word lengths:", word_lengths)
``` 
* **Tuple** coordinates = (10, 20) Ordered, immutable collection of items.The key characteristic of tuples: once created, their contents cannot be altered.
```
# Create a tuple
colors = ("red", "green", "blue")

# Print the original tuple
print("Original tuple:", colors)

# Try to modify the tuple
try:
    colors[0] = "yellow"
except TypeError as e:
    print("Error:", e)

# Verify the tuple remains unchanged
print("Tuple after attempted modification:", colors)

# Output
#Original tuple: ('red', 'green', 'blue')
#Error: 'tuple' object does not support item assignment
#Tuple after attempted modification: ('red', 'green', 'blue')
``` 
* **Range** numbers = range(1, 6)  # represents numbers 1 to 5 Immutable sequence of numbers
* **Mapping Type Dictionary (dict)** person = {"name": "Bob", "age": 30} Key-value pairs
* **Set Types Set** unique_numbers = {1, 2, 3, 4, 5} Unordered collection of unique items. Unlike lists or tuples, sets in Python do not support direct indexing or key-based access to individual elements. This is because sets are unordered collections of unique elements. However, there are several ways to access individual elements of a set such as for loop.
```python
# Creating a set
fruits = {"apple", "banana", "cherry"}

# Printing the set
print(fruits)

# Adding an element to the set
fruits.add("orange")

# Trying to add a duplicate element (will be ignored)
fruits.add("apple")

# Removing an element from the set
fruits.remove("banana")

set1 = {1, 2, 3, 4, 5}
set2 = {4, 5, 6, 7, 8}
print("Difference (set1 - set2):", set1 - set2) #Difference (set1 - set2): {1, 2, 3}
print("Union:", set1 | set2) # Union: {1, 2, 3, 4, 5, 6, 7, 8}
print("Intersection:", set1 & set2) # Intersection: {4, 5}

empty_set = set()
print(type(empty_set))  # Output: <class 'set'>

my_set = {1, 2, 3, 4, 5}
for element in my_set:
    print(element)
my_list = list(my_set)
print(my_list[0])  # Prints the first element
``` 
* **Frozenset** immutable_set = frozenset([1, 2, 3]) Immutable version of set
* **Binary Types Bytes** data = b"hello" Immutable sequence of bytes
* **Bytearray** mutable_bytes = bytearray(b"hello") Mutable sequence of bytes
* **Memoryview** view = memoryview(bytes(5)) Memory view of specified bytes
* **None Type NoneType** result = None Represents absence of value
* **from decimal import Decimal** precise_num = Decimal('0.1') High-precision decimal numbers
* **from fractions import Fraction** frac = Fraction(1, 3)  # represents 1/3 Rational numbers
* **from datetime import datetime** now = datetime.now() Date and time representation
* **iterators** An iterator is an object that allows you to iterate over a sequence (such as a list, tuple, or string) one element at a time. It is a fundamental concept in Python and is used extensively in various parts of the language.
```python
my_list = [1, 2, 3, 4, 5]
my_iterator = iter(my_list)

#Once you have an iterator, you can iterate over it using a for loop or the next() function. Here's an example:
for element in my_iterator:
    print(element)
print(next(my_iterator))  # prints 1
print(next(my_iterator))  # prints 2
print(next(my_iterator))  # prints 3

## Iterator Class
class MyIterator:
    def __init__(self, data):
        self.data = data
        self.index = 0

    def __iter__(self):
        return self

    def __next__(self):
        if self.index >= len(self.data):
            raise StopIteration
        element = self.data[self.index]
        self.index += 1
        return element

my_iterator = MyIterator([1, 2, 3, 4, 5])
for element in my_iterator:
    print(element)
```
* **type hint** Type hints in Python are a way to annotate variables, function parameters, and return values with type information
```python
from typing import List, Dict, Tuple, Set, Optional, Union
import pandas as pd
import numpy as np

def greet(name: str) -> str:
    return f"Hello, {name}!"

def add_numbers(a: int, b: int) -> int:
    return a + b

def is_even(num: int) -> bool:
    return num % 2 == 0

def get_length(sequence: Union[str, List[int]]) -> int:
    return len(sequence)

def get_first_element(sequence: Tuple[int, ...]) -> int:
    return sequence[0]

def count_unique(items: Set[str]) -> int:
    return len(items)

def get_name(person: Dict[str, str]) -> str:
    return person["name"]

def process_data(data: Optional[List[int]]) -> List[int]:
    if data is None:
        return []
    else:
        return [x * x for x in data]

def create_pandas_dataframe(data: List[Dict[str, int]]) -> pd.DataFrame:
    return pd.DataFrame(data)

def create_numpy_array(data: List[List[float]]) -> np.ndarray:
    return np.array(data)

def get_numpy_array_element(arr: np.ndarray, i: int, j: int) -> float:
    return arr[i, j]

# Usage examples
print(greet("Alice"))  # type: str
print(add_numbers(3, 4))  # type: int
print(is_even(7))  # type: bool
print(get_length("hello"))  # type: int
print(get_length([1, 2, 3]))  # type: int
print(get_first_element((10, 20, 30)))  # type: int
print(count_unique({"apple", "banana", "cherry"}))  # type: int
print(get_name({"name": "Bob", "age": 30}))  # type: str
print(process_data([1, 2, 3]))  # type: List[int]
print(process_data(None))  # type: List[int]

# Pandas DataFrame example
data = [{"name": "Alice", "age": 25}, {"name": "Bob", "age": 30}]
df = create_pandas_dataframe(data)  # type: pd.DataFrame
print(df)

# NumPy array example
arr = create_numpy_array([[1.0, 2.0], [3.0, 4.0]])  # type: np.ndarray
print(arr)
print(get_numpy_array_element(arr, 1, 1))  # type: float
```
* `__name__` variable in Python is a special variable that holds the name of the current module. It's commonly used to determine whether a script is being run directly or being imported as a module. The `if __name__ == "__main__"`: idiom in Python is a common pattern used to control the execution of code when a script is run directly versus when it's imported as a module. when you run the script directly, then the `__name__` is assigned with `__main__` but when you import and execute then the `__name__` is assigned with **my_script**.
```python
# Example file: my_script.py

print(f"The value of __name__ is: {__name__}")

def greet(name):
    return f"Hello, {name}!"

def main():
    print("This is the main function")
    print(greet("Alice"))

if __name__ == "__main__":
    print("This script is being run directly")
    main()
else:
    print("This script is being imported as a module")

def main():
    print("This is the main function")

if __name__ == "__main__":
    main()
``` 

### Inputs
* **t = input("Argument")** In Python, the input() function always returns a string by default, regardless of what type of data the user enters. This is an important characteristic to understand when working with user input in Python.
```python
# Example 1: Numeric input
age = input("Enter your age: ")
print(type(age))  # Output: <class 'str'>

# To use as a number:
age_num = int(age)

# Example 2: Multiple values
coordinates = input("Enter x and y coordinates: ")
print(coordinates)  # Output: The entire input as one string

# To separate:
x, y = coordinates.split()

# Example 3: Boolean input
answer = input("Are you ready? (yes/no): ")
is_ready = answer.lower() == 'yes'
```
* **If condition**
```python
# Sample variables
age = 20
is_student = True
score = 75

# If statement
print("Basic if statement:")
if age >= 18:
    print("You are an adult.")

# If-else statement
print("\nIf-else statement:")
if is_student:
    print("You get a student discount.")
else:
    print("Regular price applies.")

# If-elif-else statement
print("\nIf-elif-else statement:")
if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
else:
    grade = "D"
print(f"Your grade is: {grade}")

# Nested if statement
print("\nNested if statement:")
if age >= 18:
    if is_student:
        print("You are an adult student.")
    else:
        print("You are an adult, but not a student.")

# Ternary operator
print("\nTernary operator:")
message = "Can vote" if age >= 18 else "Cannot vote"
print(message)

# Ternary operator with more complex expression
discount = 20 if is_student and age < 25 else 10 if age >= 60 else 0
print(f"Your discount is: {discount}%")

name = ""
greeting = name if name else "Hello, stranger!"
```
* **Loops**
```python
# Basic for loop
print("Basic for loop:")
for i in range(3):
    print(i)

# For loop with a list
print("\nFor loop with a list:")
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)

# While loop
print("\nWhile loop:")
count = 0
while count < 3:
    print(count)
    count += 1

# Nested loops
print("\nNested loops:")
for i in range(2):
    for j in range(2):
        print(f"({i}, {j})")

# Loop with enumerate
print("\nLoop with enumerate:")
for index, fruit in enumerate(fruits):
    print(f"{index}: {fruit}")

# Loop with break
print("\nLoop with break:")
for i in range(5):
    if i == 3:
        break
    print(i)

# Loop with continue
print("\nLoop with continue:")
for i in range(5):
    if i == 2:
        continue
    print(i)

# List comprehension
print("\nList comprehension:")
squares = [x**2 for x in range(5)]
print(squares)

# For loop with else
print("\nFor loop with else:")
for i in range(3):
    print(i)
else:
    print("Loop completed")
``` 
* **List Comprehension** List comprehension is a concise way to create a new list from an existing list or other iterable by applying a transformation or filtering condition. It's a powerful feature in Python that allows you to create lists in a more readable and efficient manner.  List comprehensions are usually faster because: a) They are optimized at the C level in CPython (the standard Python implementation). b) They avoid the overhead of repeatedly calling the append() method. c) They can preallocate the necessary memory more efficiently. List comprehensions are faster than creating an empty list and appending to it in a loop
```python
import timeit

def using_append():
    result = []
    for i in range(10000):
        result.append(i * 2)
    return result

def using_comprehension():
    return [i * 2 for i in range(10000)]

# Time the append method
append_time = timeit.timeit(using_append, number=1000)

# Time the list comprehension
comprehension_time = timeit.timeit(using_comprehension, number=1000)

print(f"Append method time: {append_time:.6f} seconds")
print(f"List comprehension time: {comprehension_time:.6f} seconds")
print(f"List comprehension is {append_time / comprehension_time:.2f}x faster")
``` 
* **Destructuring**, also known as unpacking, is a feature in Python that allows you to assign multiple values to multiple variables in a single operation. It works with tuples, lists, and dictionaries.
```python
# Tuple unpacking
print("Tuple unpacking:")
point = (3, 4)
x, y = point
print(f"x: {x}, y: {y}")

# List unpacking
print("\nList unpacking:")
colors = ['red', 'green', 'blue']
color1, color2, color3 = colors
print(f"color1: {color1}, color2: {color2}, color3: {color3}")

# Dictionary unpacking
print("\nDictionary unpacking (keys):")
person = {'name': 'John', 'age': 30, 'city': 'New York'}
name, age, city = person.keys()
print(f"name: {name}, age: {age}, city: {city}")

print("\nDictionary unpacking (values):")
name, age, city = person.values()
print(f"name: {name}, age: {age}, city: {city}")

print("\nDictionary unpacking (items):")
(name, age), city = person.items()
print(f"name: {name}, age: {age}, city: {city}")

# Unpacking with wildcards
print("\nUnpacking with wildcards:")
numbers = [1, 2, 3, 4, 5]
first, *middle, last = numbers
print(f"first: {first}, middle: {middle}, last: {last}")

# Unpacking nested tuples
print("\nUnpacking nested tuples:")
nested_tuple = ((1, 2), (3, 4))
((a, b), (c, d)) = nested_tuple
print(f"a: {a}, b: {b}, c: {c}, d: {d}")

# Unpacking nested dictionaries
print("\nUnpacking nested dictionaries:")
nested_dict = {'person': {'name': 'John', 'age': 30}, 'address': {'city': 'New York'}}
person, address = nested_dict.items()
name, age = person['person'].values()
city = address['address']['city']
print(f"name: {name}, age: {age}, city: {city}")

# Unpacking in for loops
print("\nUnpacking in for loops (tuples):")
points = [(1, 2), (3, 4), (5, 6)]
for x, y in points:
    print(f"x: {x}, y: {y}")

print("\nUnpacking in for loops (dictionaries):")
people = [
    {'name': 'John', 'age': 30},
    {'name': 'Jane', 'age': 25},
    {'name': 'Bob', 'age': 35}
]
for person in people:
    name, age = person.values()
    print(f"name: {name}, age: {age}")

data = (10, 20, 30)
a, _, b = data
print(a)  # Output: 10
print(b)  # Output: 30

point = (1, 2, 3, 4, 5)
x, *_, y = point
print(x)  # Output: 1
print(y)  # Output: 5

data = [(1, 2), (3, 4), (5, 6)]
for a, _ in data:
    print(a)

numbers = [1, 2, 3, 4, 5]
first, *rest = numbers
print(first)  # Output: 1
print(rest)   # Output: [2, 3, 4, 5]

word = "python"
first, *middle, last = word
print(first)   # Output: 'p'
print(middle)  # Output: ['y', 't', 'h', 'o']
print(last)    # Output: 'n'

point = (1, 2, 3, 4, 5)
x, *y, z = point
print(x)  # Output: 1
print(y)  # Output: [2, 3, 4]
print(z)  # Output: 5

nested_list = [[1, 2], [3, 4], [5, 6]]
first, *middle, last = nested_list
print(first)    # Output: [1, 2]
print(middle)   # Output: [[3, 4]]
print(last)     # Output: [5, 6]
```
* **Function**  In Python, when a function does not have an explicit return statement or if the return statement is reached without any value specified, the function implicitly returns None
```python
# Function with pass statement
def empty_function():
    pass

# Calling the empty function
empty_function()

# Function that returns None
def say_hello(name):
    print(f"Hello, {name}!")

# Calling the function that returns None
result = say_hello("Alice")
print(result)  # Output: Hello, Alice!

# Function that performs simple math
def add_numbers(a, b):
    return a + b

# Calling the math function
num1 = 10
num2 = 20
sum_of_numbers = add_numbers(num1, num2)
print(f"The sum of {num1} and {num2} is: {sum_of_numbers}")

# Function that performs subtraction
def subtract_numbers(a, b):
    return a - b

# Calling the subtraction function
num3 = 30
num4 = 15
difference = subtract_numbers(num3, num4)
print(f"The difference between {num3} and {num4} is: {difference}")

# Function that performs multiplication
def multiply_numbers(a, b):
    return a * b

# Calling the multiplication function
num5 = 5
num6 = 6
product = multiply_numbers(num5, num6)
print(f"The product of {num5} and {num6} is: {product}")

# Function that performs division
def divide_numbers(a, b):
    if b == 0:
        return None

# Default parameters
def greet(name, greeting="Hello"):
    print(f"{greeting}, {name}!")

# Calling the function with required argument
greet("Alice")
# Output: Hello, Alice!
```
* **Lambda functions**, also known as anonymous functions, are small, one-line short functions in Python that can take any number of arguments but can only have one expression. They are defined using the lambda keyword and are useful when you need a simple function for a short period of time. **lambda arguments: expression**
```python
# Simple lambda function
square = lambda x: x**2
print(square(5))  # Output: 25

# Lambda function with multiple arguments
add_numbers = lambda x, y: x + y
result = add_numbers(10, 20)
print(result)  # Output: 30

# Using lambda functions with built-in functions
numbers = [1, 2, 3, 4, 5]
doubled_numbers = list(map(lambda x: x*2, numbers))
print(doubled_numbers)  # Output: [2, 4, 6, 8, 10]

# Filtering using lambda functions
even_numbers = list(filter(lambda x: x%2 == 0, numbers))
print(even_numbers)  # Output: [2, 4]

# Sorting using lambda functions
people = [
    {"name": "Alice", "age": 25},
    {"name": "Bob", "age": 30},
    {"name": "Charlie", "age": 20}
]

sorted_people = sorted(people, key=lambda person: person["age"])
print(sorted_people)
# Output: [
#     {"name": "Charlie", "age": 20},
#     {"name": "Alice", "age": 25},
#     {"name": "Bob", "age": 30}
# ]

# Nested lambda functions
adder = lambda x: lambda y: x + y
add_five = adder(5)
result = add_five(10)
print(result)  # Output: 15

# Lambda function with if-else
is_even = lambda x: "Even" if x % 2 == 0 else "Odd"
print(is_even(7))  # Output: Odd
print(is_even(8))  # Output
```
* **map**  The map() function in Python is used to apply a function of one argument to each item of a list, tuple, or string. It returns an iterator that applies the function to every item of the iterable and returns a list of the results. An iterator is an object that can be iterated upon, meaning you can traverse through all the values.
```python
# map(function, iterable)
numbers = [1, 2, 3, 4, 5]
squared_numbers = list(map(lambda x: x**2, numbers))
print(squared_numbers)  # Output: [1, 4, 9, 16, 25]
``` 
* **Unpacking arguments** The `*` operator is used to unpack positional arguments. The `**` operator is used to unpack keyword arguments. Positional arguments:
These are arguments passed to a function in a specific order that matches the order of parameters defined in the function. Keyword arguments: These are arguments passed to a function using the parameter names, followed by an equals sign and the value.
```python
def my_function(*args):
    for arg in args:
        print(arg)

my_function('hello', 'world', 'python')

def my_function(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

my_function(name='John', age=30, city='New York')

def my_function(*args, **kwargs):
    for arg in args:
        print(arg)
    for key, value in kwargs.items():
        print(f"{key}: {value}")

my_function('hello', 'world', name='John', age=30, city='New York')

def my_function(a, b, c):
    print(a, b, c)

my_list = [1, 2, 3]
my_function(*my_list)  # Output: 1 2 3

def my_function(a, b, c):
    print(a, b, c)

my_dict = {'a': 1, 'b': 2, 'c': 3}
my_function(**my_dict)  # Output: 1 2 3
``` 
* **Object Oriented Method**
```python
class Car:
    def __init__(self, make, model, year):
        self.make = make
        self.model = model
        self.year = year
        self.speed = 0

    def accelerate(self):
        self.speed += 5
        return f"{self.make} {self.model} is now going {self.speed} mph"

    def brake(self):
        if self.speed >= 5:
            self.speed -= 5
        else:
            self.speed = 0
        return f"{self.make} {self.model} slowed down to {self.speed} mph"

    def honk(self):
        return f"{self.make} {self.model} goes 'Beep beep!'"

# Creating instances of the Car class
my_car = Car("Toyota", "Corolla", 2020)
friend_car = Car("Honda", "Civic", 2019)

# Using the methods
print(my_car.accelerate())
print(my_car.accelerate())
print(my_car.brake())
print(my_car.honk())

print(friend_car.accelerate())
print(friend_car.honk())
```
* **Magic Methods** Magic methods are special methods in Python that start and end with double underscores, like __init__ or __str__. They are also called "dunder" (double underscore) methods.
  **__init__**: Constructor, **__str__**: String representation, **__repr__**: Detailed string representation, **__len__**: Length of the object, **__getitem__**: Accessing items with indexing, **__call__**: Making the object callable, **__eq__**: Equality comparison, **__lt__**: Less than comparison (also enables sorting), **__add__**: Addition operation, **__enter__** and **__exit__**: Context manager protocol. Arithmetic operators like __add__, __sub__, __mul__: Overload operators for objects. Magic methods provide a way to make your custom objects behave more like built-in types in Python. For example, overloading the + operator with __add__ allows you to add your own objects together.  Magic methods are automatically invoked by Python when certain operations are performed on an object. You don't call them directly, but rather Python calls them under the hood when the corresponding operation is used.
```python
class Book:
    def __init__(self, title, author, pages):
        self.title = title
        self.author = author
        self.pages = pages
        self.current_page = 1

    def __str__(self):
        return f"'{self.title}' by {self.author}"

    def __repr__(self):
        return f"Book(title='{self.title}', author='{self.author}', pages={self.pages})"

    def __len__(self):
        return self.pages

    def __getitem__(self, page):
        if 1 <= page <= self.pages:
            return f"Content of page {page}"
        else:
            raise IndexError("Page number out of range")

    def __call__(self):
        return f"Reading '{self.title}'..."

    def __eq__(self, other):
        if isinstance(other, Book):
            return self.title == other.title and self.author == other.author
        return False

    def __lt__(self, other):
        if isinstance(other, Book):
            return self.pages < other.pages
        return NotImplemented

    def __add__(self, other):
        if isinstance(other, Book):
            return self.pages + other.pages
        return NotImplemented

    def __enter__(self):
        print(f"Opening '{self.title}'")
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        print(f"Closing '{self.title}'")

# Creating instances
book1 = Book("Python Basics", "John Doe", 200)
book2 = Book("Advanced Python", "Jane Smith", 300)

# Demonstrating magic methods
print(str(book1))  # __str__
print(repr(book2))  # __repr__

print(len(book1))  # __len__

print(book1[50])  # __getitem__

print(book2())  # __call__

print(book1 == Book("Python Basics", "John Doe", 200))  # __eq__
print(book1 < book2)  # __lt__

print(book1 + book2)  # __add__

# Context manager
with Book("Context Managers in Python", "Alice Johnson", 150) as book:
    print("Reading inside the context manager")

# Additional examples
print(f"Book 1 is {book1}")  # Uses __str__
print(f"Book 2 representation: {book2!r}")  # Uses __repr__

try:
    print(book1[500])  # This will raise an IndexError
except IndexError as e:
    print(f"Error: {e}")

# Comparing and sorting books
books = [book1, book2, Book("Python Cookbook", "David Beazley", 250)]
sorted_books = sorted(books)
print("Sorted books by number of pages:")
for book in sorted_books:
    print(f"{book.title}: {book.pages} pages")
```
```python
class MyClass:
    def __init__(self, value):
        self.value = value

    def __add__(self, other):
        return self.value + other.value

obj1 = MyClass(5)
obj2 = MyClass(10)

# This line:
result = obj1 + obj2

# Is equivalent to this behind the scenes:
result = MyClass.__add__(obj1, obj2)
```
* **super().init()**  in single inheritance allows a child class to call the init() method of its parent class. This is useful for initializing attributes defined in the parent class while adding new attributes or behavior in the child class.
```python
class Parent:
    def __init__(self, name):
        self.name = name

class Child(Parent):
    def __init__(self, name, age):
        super().__init__(name)  # Call parent's __init__
        self.age = age  # Add child-specific attribute

child = Child("Alice", 10)
print(child.name)  # Output: Alice
print(child.age)   # Output: 10
``` 
* **Instance Methods:** Definition: Instance methods are defined with the self parameter, which refers to the instance of the class. Use Cases: Accessing and modifying instance attributes. Performing operations that are specific to the instance of the class. Calling other instance methods or class methods.
```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def greet(self):
        print(f"Hello, my name is {self.name} and I'm {self.age} years old.")
```
In this example, the greet() method is an instance method that can access and use the name and age attributes of the Person instance.
* **Class Methods:** Definition: Class methods are defined with the cls parameter, which refers to the class itself. Use Cases: Accessing and modifying class attributes. Implementing alternative constructors or factory methods. Performing operations that are specific to the class, rather than the instance.
```python
class Person:
    population = 0

    def __init__(self, name, age):
        self.name = name
        self.age = age
        Person.population += 1

    @classmethod
    def get_population(cls):
        return cls.population
```
In this example, the get_population() method is a class method that can access and return the population class attribute.
* **Static Methods:** Definition: Static methods are defined without any implicit parameters (like self or cls). Use Cases: Providing utility functions that don't need to access instance or class attributes.
Grouping related functions within a class for better organization. Implementing mathematical or logical operations that don't depend on the class or instance state.
```python
import math

class Circle:
    def __init__(self, radius):
        self.radius = radius

    def area(self):
        return self.calculate_area(self.radius)

    @staticmethod
    def calculate_area(radius):
        return math.pi * radius ** 2
```
In this example, the calculate_area() method is a static method that can be called without an instance of the Circle class. It performs a mathematical calculation that doesn't depend on any instance or class attributes.
* **class inheritance** Inheritance is a fundamental concept in object-oriented programming (OOP) that allows a new class to be based on an existing class. Use inheritance when: You want to model an "is-a" relationship between classes. You need to extend or modify the behavior of a base class. You want to share common functionality across multiple related classes

```python
class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        print(f"{self.name} makes a sound.")

class Dog(Animal):
    def __init__(self, name):
        super().__init__(name)

    def speak(self):
        print(f"{self.name} barks.")

class Cat(Animal):
    def __init__(self, name):
        super().__init__(name)

    def speak(self):
        print(f"{self.name} meows.")

# Creating instances
animal = Animal("Generic Animal")
dog = Dog("Buddy")
cat = Cat("Whiskers")

# Calling methods
animal.speak()  # Output: Generic Animal makes a sound.
dog.speak()  # Output: Buddy barks.
cat.speak()  # Output: Whiskers meows.


class Vehicle:
    def __init__(self, brand):
        self.brand = brand

    def move(self):
        return "Moving..."

class Car(Vehicle):
    def move(self):
        return "Driving on the road"

class Boat(Vehicle):
    def move(self):
        return "Sailing on water"

# Usage
car = Car("Toyota")
boat = Boat("Yamaha")
print(car.move())  # Output: Driving on the road
print(boat.move())  # Output: Sailing on water
#In this example, Car and Boat inherit from Vehicle because they are types of vehicles.
```
* **Class composition** in Python refers to the practice of building complex objects by combining simpler objects, rather than through inheritance. Use composition when:
You want to model a "has-a" relationship between classes. You need more flexibility in your design. You want to combine behaviors of multiple classes without creating complex inheritance hierarchies

```python
class Engine:
    def __init__(self, horsepower):
        self.horsepower = horsepower

    def start(self):
        print("Engine started")

class Car:
    def __init__(self, color, engine):
        self.color = color
        self.engine = engine

    def drive(self):
        self.engine.start()
        print(f"Driving a {self.color} car")

# Create an engine object
engine = Engine(200)

# Create a car object, passing the engine object as a parameter
car = Car("Red", engine)

# Drive the car
car.drive()


class Engine:
    def start(self):
        return "Engine started"

class Wheels:
    def rotate(self):
        return "Wheels rotating"

class Car:
    def __init__(self):
        self.engine = Engine()
        self.wheels = Wheels()

    def drive(self):
        return f"{self.engine.start()}, {self.wheels.rotate()}"

# Usage
my_car = Car()
print(my_car.drive())  # Output: Engine started, Wheels rotating
# In this example, Car is composed of Engine and Wheels objects, demonstrating a "has-a" relationship.
```
* **Composition and Inheritence**
```python
class Engine:
    def start(self):
        return "Engine started."

class ElectricMotor:
    def start(self):
        return "Electric motor activated."

class Car:
    def __init__(self, power_source):
        self.power_source = power_source

    def start(self):
        return self.power_source.start()

# Usage
combustion_engine = Engine()
electric_motor = ElectricMotor()

car = Car(combustion_engine)
print(car.start())  # Output: Engine started.

car.power_source = electric_motor
print(car.start())  # Output: Electric motor activated.


class Vehicle:
    def start(self):
        pass

class CombustionCar(Vehicle):
    def start(self):
        return "Engine started."

class ElectricCar(Vehicle):
    def start(self):
        return "Electric motor activated."

# Usage
combustion_car = CombustionCar()
print(combustion_car.start())  # Output: Engine started.

electric_car = ElectricCar()
print(electric_car.start())  # Output: Electric motor activated.

# Composition: Allows changing the power source at runtime. Inheritance: Requires creating new objects for different types.
# Composition: Power sources can be reused in different contexts. Inheritance: Behavior is tightly coupled to the car type.
# Composition: Easy to add new power sources without modifying existing code. Inheritance: Adding new types requires new subclasses.
# Composition: Simpler to understand and maintain. Inheritance: Can lead to complex hierarchies as more types are added.
# Composition: Can change behavior dynamically. Inheritance: Behavior is fixed at object creation.


Inheritence is more suitable than composition

class Shape:
    def __init__(self, color):
        self.color = color
    
    def area(self):
        pass

class Circle(Shape):
    def __init__(self, color, radius):
        super().__init__(color)
        self.radius = radius
    
    def area(self):
        return 3.14 * self.radius ** 2

class Rectangle(Shape):
    def __init__(self, color, width, height):
        super().__init__(color)
        self.width = width
        self.height = height
    
    def area(self):
        return self.width * self.height

# Usage
shapes = [Circle("red", 5), Rectangle("blue", 4, 6)]
for shape in shapes:
    print(f"Area of {shape.__class__.__name__}: {shape.area()}")


class AreaCalculator:
    def circle_area(self, radius):
        return 3.14 * radius ** 2
    
    def rectangle_area(self, width, height):
        return width * height

class Circle:
    def __init__(self, radius, calculator):
        self.radius = radius
        self.calculator = calculator
    
    def area(self):
        return self.calculator.circle_area(self.radius)

class Rectangle:
    def __init__(self, width, height, calculator):
        self.width = width
        self.height = height
        self.calculator = calculator
    
    def area(self):
        return self.calculator.rectangle_area(self.width, self.height)

# Usage
calculator = AreaCalculator()
shapes = [Circle(5, calculator), Rectangle(4, 6, calculator)]
for shape in shapes:
    print(f"Area of {shape.__class__.__name__}: {shape.area()}")


```             
* **Absolute and relative import**
```python
from project.module1 import function1
from .module2 import function2
from ..package1.module3 import function3
```
* **Erros**
```python
# SyntaxError
def greet(name):
    print("Hello, " + name!)  # Missing closing parenthesis

# NameError 
print(x)  # x is not defined

# TypeError
print(5 + "hello")  # Cannot concatenate int and str
def add(a, b):
    return a + b
add(1, 2, 3)  # TypeError: add() takes 2 positional arguments but 3 were given

# IndexError
my_list = [1, 2, 3]
print(my_list[3])  # Index out of range

# KeyError
my_dict = {"name": "Alice", "age": 25}
print(my_dict["city"])  # Key "city" does not exist

# ZeroDivisionError
print(10 / 0)  # Division by zero

# ImportError
from math import sqrt2  # sqrt2 does not exist in math module
print(sqrt2(4))

a, b = [1, 2, 3]  # ValueError: too many values to unpack (expected 2)

import math
math.sqrt(-1)  # ValueError: math domain error

int("hello")  # ValueError: invalid literal for int() with base 10: 'hello'
```
* **first-class functions**
```python
def greet(name):
    return f"Hello, {name}!"

def apply_twice(func, arg):
    return func(arg) + func(arg)

# Using first-class functions
greeting = greet
print(greeting("Alice"))  # Output: Hello, Alice!

result = apply_twice(greet, "Bob")
print(result)  # Output: Hello, Bob!Hello, Bob!
```
* **Association** relation between classes where objects of one class are connected to objects of another class. Composition, on the other hand, is a specific and stronger form of association13. It represents a "part-of" relationship where:
```python
# Association
class Department:
    def __init__(self, name):
        self.name = name

class Employee:
    def __init__(self, name, department):
        self.name = name
        self.department = department  # Association

# Composition
class Engine:
    def __init__(self, power):
        self.power = power

class Car:
    def __init__(self, model):
        self.model = model
        self.engine = Engine("100hp")  # Composition

# Usage
dept = Department("IT")
emp = Employee("Alice", dept)

car = Car("Tesla")
# Employee has an association with Department.
# Car has a composition relationship with Engine.
# The key difference is that the Engine is created within the Car and is part of its lifecycle, while the Department exists independently of the Employee.
```
* **Association and Composition**
```python
class Engine:
    def __init__(self, power):
        self.power = power

class Car:
    def __init__(self, model):
        self.model = model
        self.engine = Engine("100hp")  # Composition

    def __del__(self):
        print(f"Car {self.model} is being destroyed, engine goes with it.")

# Usage
car = Car("Tesla")
print(f"Car model: {car.model}, Engine power: {car.engine.power}")

# When car is deleted, its engine is automatically deleted too
del car
# In this example, the Engine is created within the Car and is part of its lifecycle. When the Car object is destroyed, its Engine is automatically destroyed with it.

class Department:
    def __init__(self, name):
        self.name = name

class Employee:
    def __init__(self, name, department):
        self.name = name
        self.department = department  # Association

# Usage
it_dept = Department("IT")
alice = Employee("Alice", it_dept)
bob = Employee("Bob", it_dept)

print(f"{alice.name} works in {alice.department.name}")
print(f"{bob.name} works in {bob.department.name}")

# The department can exist independently of employees
del alice
del bob
print(f"Department {it_dept.name} still exists")
# In this association example, the Department exists independently of the Employee. Multiple employees can be associated with the same department, and the department continues to exist even if all employees are deleted.
``` 
* **Decorators** can be used to add a wide range of functionality to functions, such as logging, caching, authentication
```python
def print_password(func):
    def wrapper(*args, **kwargs):
        result = func(*args, **kwargs)
        print(f"The password is: {result}")
        return result
    return wrapper

@print_password
def get_password():
    return "mySecurePassword123"

# Usage
password = get_password()
# Output:
# The password is: mySecurePassword123


def requires_role(role):
    def decorator(func):
        def wrapper(user, *args, **kwargs):
            if user.role != role:
                raise PermissionError("Access Denied")
            return func(user, *args, **kwargs)
        return wrapper
    return decorator

@requires_role("admin")
def view_sensitive_data(user):
    return "Sensitive Data"

# Main calling part
class User:
    def __init__(self, role):
        self.role = role

if __name__ == "__main__":
    admin_user = User(role="admin")
    regular_user = User(role="user")

    # This should work
    try:
        result = view_sensitive_data(admin_user)
        print(f"Admin access successful: {result}")
    except PermissionError as e:
        print(f"Error: {e}")

    # This should raise a PermissionError
    try:
        result = view_sensitive_data(regular_user)
        print(f"Regular user access successful: {result}")
    except PermissionError as e:
        print(f"Error: {e}")
#This main section creates two users (admin and regular) and attempts to call the view_sensitive_data function with each.
# The admin user should succeed, while the regular user should be denied access.
```
When get_password is called, the wrapper function is executed instead of the original get_password function. Inside the wrapper, the original get_password is called with () (no arguments), and its result is stored in result. The print(f"The password is: {result}") statement is executed, printing the password. Finally, the result is returned from the wrapper function and assigned to the password variable.
 * **Design patterns** provide proven solutions to common design problems. They promote code reuse, flexibility, and maintainability by separating concerns and defining clean interfaces between components
 **Creational Patterns** Factory Method Abstract Factory  Builder Prototype Singleton **Structural Patterns** Adapter Bridge  Composite Decorator Facade Flyweight Proxy **Behavioral Patterns** Chain of Responsibility Command Interpreter Iterator Mediator Memento Observer State Strategy Template Method Visitor
