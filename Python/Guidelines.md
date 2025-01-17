# Python Guidelines

Python has several guidelines (Example : **Google Python Style Guide and PEP 8**) and best practices to ensure clean, readable, and consistent code. Here's a short explanation of key Python coding guidelines:

* **Indentation and Line Length** Use 4 spaces per indentation level, Use spaces instead of tabs for indentation, Surround top-level function and class definitions with two blank lines and Limit all lines to a maximum of 79 characters
* **UTF-8** is a versatile character encoding system used for representing text in computers and digital communication. Unicode is a character encoding system **standard** that assigns a unique numerical value, called a code point, to every character used in written languages and symbols.
* Code Points: Each character in Unicode is assigned a unique code point, represented as U+[hexadecimal number]. For example, the English letter 'A' is U+00413. Character Set: Unicode can represent nearly 1,114,112 characters, covering almost all known writing systems15
```python
print("Hello, 世界")
```
* **Group imports in the order**: standard library, third-party, local
```python
import os
import sys

import numpy as np
import pandas as pd

from mypackage import mymodule
```
* **Comments**
```python
# This is a proper inline comment
x = 5  # This explains the non-obvious
```
* **Line Breaks and Continuations**
```python
# Using parentheses for implicit line continuation
long_function_call(arg1, arg2,
                   arg3, arg4)

# Using backslashes when necessary
very_long_variable_name = \
    "This is a long string that needs to be split."

# Indenting continued lines
def long_function_name(
        var_one, var_two, var_three,
        var_four):
    print(var_one)
```
* **Whitespace**
```python
x = [1, 2, 3, 4]  # Comma followed by space
def func(x=None):  # No space around = in default arg
y = x * 2  # Spaces around *
print("Hello")  # No space inside parentheses
```
* **Error Handling**
```python
try:
    result = x / y
except ZeroDivisionError as e:
    print(f"Error: {e}")
except Exception as e:
    print(f"Unexpected error: {e}")
``` 
* **Naming Conventions**
```python
def calculate_average(numbers):  # Function name
    pass

class UserProfile:  # Class name
    pass

user_age = 25  # Variable name

MAX_CONNECTIONS = 100  # Constant
``` 
* **NamingConvention** The Google Style Guide previously recommended **CamelCase** for functions and methods, whereas PEP 8 suggests **snake_case**.  However, this difference appears to have been removed in recent updates to the Google Style Guide.
1. Camel Case (camelCase): Example: getUserData, calculateTotalAmount 
2. Pascal Case (PascalCase): Example: UserProfile, DatabaseConnection
3. Snake Case (snake_case): Example: user_login_count, calculate_total_amount
4. Kebab Case (kebab-case): Example: user-profile, background-color

* **Docstring** provides a clear description of the function, its parameters, and the return value.
```python
def add_binary(a, b):
    """
    Return the sum of two decimal numbers in binary digits.

    Parameters:
    a (int): A decimal integer
    b (int): Another decimal integer

    Returns:
    str: Binary string of the sum of a and b
    """
    binary_sum = bin(a + b)[2:]
    return binary_sum

print(add_binary.__doc__)
```
* **type hints** specifies data types for function parameters and return values. The **Union** type from the typing module in Python is used to indicate that a variable can be one of several specified types.
```python
def add(a: int, b: int):
    return a + b


def add(a: int, b: int) -> int:
    return a + b


from typing import Union

def add2(a: Union[int, float]) -> Union[int, float]: # Union[int, float] or int | float
    return a + 2

``` 
