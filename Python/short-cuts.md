# Python short cuts

### Print all attributes of an object
```
from pprint import pprint

objectname.__dir__() method
pprint(dir(objectname))
pprint(vars(objectname))
```
### Print all variables, functions, or objects in a program
```
from pprint import pprint
dir()
pprint(vars())
```

# Numpy
size (total number of elements), dimension (number of dimension), shape (length in each dimension) of the array
```
variable_name.size
len(variable_name) # returns the size or length of the first dimension

variable_name.ndim

variable_name.shape
row, col = variable_name.shape
```

