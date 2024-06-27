# Python

### Variables - Name for a value in python
Python evaluates the right side of the assignment first. When variable y=2 and x=y then both variables refer to the same value. 
* **Integer (int)** x = 5 Whole numbers without decimal points
```python
y = 2  # It creates an integer object with the value 2.  and  It assigns the variable y to refer to this object.
x = y # Python evaluates the right side (y) first. It sees that y refers to the integer object with value 2. It then assigns x to refer to the same object.
``` 
* **Float** y = 3.14 Numbers with decimal points
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
* **Complex** z = 3 + 4j Numbers with real and imaginary parts
* **Sequence Types List** fruits = ["apple", "banana", "cherry"] Ordered, mutable collection of items
```python
fruits = ["apple", "banana"]
fruits.append("cherry")  # Modifies the original list
print(fruits)  # Output: ["apple", "banana", "cherry"]
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
* **Set Types Set** unique_numbers = {1, 2, 3, 4, 5} Unordered collection of unique items
* **Frozenset** immutable_set = frozenset([1, 2, 3]) Immutable version of set
* **Binary Types Bytes** data = b"hello" Immutable sequence of bytes
* **Bytearray** mutable_bytes = bytearray(b"hello") Mutable sequence of bytes
* **Memoryview** view = memoryview(bytes(5)) Memory view of specified bytes
* **None Type NoneType** result = None Represents absence of value
* **from decimal import Decimal** precise_num = Decimal('0.1') High-precision decimal numbers
* **from fractions import Fraction** frac = Fraction(1, 3)  # represents 1/3 Rational numbers
* **from datetime import datetime** now = datetime.now() Date and time representation


