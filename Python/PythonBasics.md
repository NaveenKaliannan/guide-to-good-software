# Python

### Variables - Name for a value in python
Python evaluates the right side of the assignment first. When variable y=2 and x=y then both variables refer to the same value. 
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
* **Unpacking arguments** The `*` operator is used to unpack positional arguments. The `**` operator is used to unpack keyword arguments.
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
