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
```
* **variable** is always string and defined at the start of the file. **make -p** gives the pre defined variable and it can be updated in our makefile as well.
* **target** 
* **prerequisites**
* **command or operation that we want to perform**

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

