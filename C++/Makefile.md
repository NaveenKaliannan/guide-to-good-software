# MakeFile and Make

Run and compile programs professionally.

## make
**make** is a command that calls the **Makefile** file. 

## Structure of Makefile
Create a file with a name **Makefile** with the below struture:
```
variable = 1

target: prerequisites
<TAB>command

.PHONY: target1 target2 ...
```
* **target** 
* **prerequisites**
* **command or operation that we want to perform**
* **variable** is always string and defined at the start of the file. **make -p** gives the pre defined variable and it can be updated in our makefile as well.
```
SOURCE_DIR=src
INCLUDE_DIR=include
CPPFLAGS= -I $(INCLUDE_DIR) #It tells the src files to where look for include header files

variable ?= "mystring" # sets mystring only if the if it is not earlier somewhere. 
```
* **PHONY** contains all the target name that will be build or executed every time when make is run, even if the source files are not edited. Otherwise executable is upto-date will be displayed. 
## Examples
### Example 1
```
build:
	g++ main.cc -o main_exe

run:
	./main_exe

clean:
	rm -f main_exe
```
* **make** will run the **build** target. **By default, the make will run the first target in the makefile**
* **make exe** will run the **exe** target
* **make build** will run the **build** target
* **make clean** will run the **clean** target
### Example 2
```
build: main1.o main2.o
	g++ main1.o main2.o -o main_exe
main1.o: 
	g++ main1.cc -c main1.o
main2.o: 
	g++ main2.cc -c main2.o
run:
	./main_exe
clean:
	rm -f main_exe *.o
```
* **make** will run the **build** target. Since the build's prerequisites contains two object files, the target **main1.o** and **main1.o** will be running first. 
### Example 3
Make variables (make -p) can be used directly instead of explicity defining exisiting variables
```
build:
	$(CXX) main.cc -o main_exe

run:
	./main_exe

clean:
	rm -f main_exe
```
We can overwrite the existing variable via the command line: **make CXX=g++ -std=c++11**

## Role of WildCards in Writing make files  

Wildcards are special characters that represents other characters.

Wild cards make life easier by stopping the repitation of command lines for each cc files.
```
$@: filename of the target
$<: evaluates the first prerequisites 
$^: evaluates all prerequisites
$%:
$?: 
$+: 
$*:
SOURCE_FILES=$(wildcard *.cc) : gives the files with cc extension
$(patsubst %.cc, %.o, $(SOURCE_FILES)) : gives the object files with names of all cc files

%.o:%.c
	g++ -c $^ -o $@

create:
	@mkdir -p build   #@ is added so the console output will be not visible
```

## loops

# if conditions
```
ifeq($(variable),1)
statement
else
statement
endif
```

