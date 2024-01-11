# Python short cuts

## Python export path
It is important to export the correct path to find the module. Otherwise ModuleNotFoundError: No module named "library-name" will show.
When exporting, the folder's path appears before the library name folder is considered. For example, if the libraries are located at
`/home/naveenk/repository-name-1/tool/library-1` and `/home/naveenk/repository-name-2/tool/library-2`, then their export path is the following:
```
export PYTHONPATH=$PYTHONPATH:/home/naveenk/repository-name-1/tool:/home/naveenk/repository-name-2/tool
```

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

