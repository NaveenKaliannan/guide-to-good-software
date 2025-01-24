# Design Patterns in Python

## Creational pattern
* **Factory Method** is a creational pattern that provides an interface for creating objects in a superclass, but allows subclasses to alter the type of objects that will be created.
```python
# This implementation focuses solely on the factory method pattern, where AnimalFactory is responsible for creating different types of animals based on the input parameter.
class Animal:
    def speak(self):
        pass

class Dog(Animal):
    def speak(self):
        return "Woof!"

class Cat(Animal):
    def speak(self):
        return "Meow!"

class AnimalFactory:
    def create_animal(self, animal_type):
        if animal_type == "dog":
            return Dog()
        elif animal_type == "cat":
            return Cat()

def main():
    factory = AnimalFactory()
    dog = factory.create_animal("dog")
    print(dog.speak())

if __name__ == "__main__":
    main()

```
* **Abstract Factory** are indeed used to ensure that certain functions must be implemented in subclasses. The use of abstract methods enables the compiler to catch missing implementations, reducing runtime errors. Subclasses are required to provide implementations for all inherited abstract methods to become concrete classes. This prevents forgetting to implement crucial functionality
```python
from abc import ABC, abstractmethod

class Animal(ABC):
    @abstractmethod
    def make_sound(self):
        pass

class Dog(Animal):
    def make_sound(self):
        return "Woof!"

class Cat(Animal):
    def make_sound(self):
        return "Meow!"

# Usage
dog = Dog()
print(dog.make_sound())  # Output: Woof!

cat = Cat()
print(cat.make_sound())  # Output: Meow!
```
* **Builder** is a creational pattern that lets you construct complex objects step by step.
```python
class Car:
    def __init__(self):
        self.parts = []

    def add(self, part):
        self.parts.append(part)

    def list_parts(self):
        return f"Car parts: {', '.join(self.parts)}"

class CarBuilder:
    def __init__(self):
        self.car = Car()

    def add_wheels(self):
        self.car.add("Wheels")
        return self

    def add_engine(self):
        self.car.add("Engine")
        return self

    def build(self):
        return self.car

def main():
    builder = CarBuilder()
    car = builder.add_wheels().add_engine().build()
    print(car.list_parts())

if __name__ == "__main__":
    main()
```
* **Prototype**  is a creational pattern that lets you copy existing objects without making your code dependent on their classes. The Prototype design pattern and copy constructors are similar in that they both involve creating copies of objects.
```python
import copy

class Sheep:
    def __init__(self, name, category):
        self.name = name
        self.category = category

    def clone(self):
        return copy.deepcopy(self)

def main():
    dolly = Sheep("Dolly", "Mountain Sheep")
    dolly_clone = dolly.clone()
    dolly_clone.name = "Dolly's clone"
    print(f"Original: {dolly.name}, Clone: {dolly_clone.name}")

if __name__ == "__main__":
    main()
```
* **Singleton** is a creational pattern that lets you ensure that a class has only one instance, while providing a global access point to this instance. A singleton always creates the same object and points to the same memory location. Characteristics : It ensures only one instance of the class is created. It provides a global point of access to that instance.
```python
class Singleton:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

def main():
    s1 = Singleton()
    s2 = Singleton()
    print(f"Same instance: {s1 is s2}")
    print(f"Memory location of s1: {hex(id(s1))}")
    print(f"Memory location of s2: {hex(id(s2))}")

if __name__ == "__main__":
    main()
```
## Structural Patterns
* **Adapter** is a structural pattern that allows objects with incompatible interfaces to collaborate. This pattern is particularly useful when integrating new components into existing systems or when working with legacy code that cannot be modified directly. The adapter class Acts as a bridge between/amoung the objects. 
```python
class EuropeanSocket:
    def voltage(self):
        return 230

class USAPlug:
    def voltage(self):
        return 110

class Adapter:
    def __init__(self, socket):
        self.socket = socket

    def voltage(self):
        return self.socket.voltage()

def main():
    socket = EuropeanSocket()
    adapter = Adapter(socket)
    print(f"Adapted voltage: {adapter.voltage()}")

if __name__ == "__main__":
    main()
```
* **Bridge** is a structural pattern that lets you split a large class or a set of closely related classes into two separate hierarchies—abstraction and implementation—which can be developed independently of each other. The core concept of the Bridge pattern, **separating the abstraction  from its implementation**, allowing them to vary independently.
```python
from abc import ABC, abstractmethod

class DrawingAPI(ABC):
    @abstractmethod
    def draw_circle(self, x, y, radius):
        pass

class DrawingAPI1(DrawingAPI):
    def draw_circle(self, x, y, radius):
        return f"API1.circle at {x}:{y} radius {radius}"

class Shape:
    def __init__(self, api):
        self.api = api

class Circle(Shape):
    def draw(self, x, y, radius):
        return self.api.draw_circle(x, y, radius)

api = DrawingAPI1()
circle = Circle(api)
print(circle.draw(1, 2, 3))

```
* **Composite** is a structural pattern that lets you compose objects into tree structures and then work with these structures as if they were individual objects.
```python
class Component:
    def operation(self):
        pass

class Leaf(Component):
    def operation(self):
        return "Leaf"

class Composite(Component):
    def __init__(self):
        self.children = []

    def add(self, component):
        self.children.append(component)

    def operation(self):
        return f"Branch({'+'.join(c.operation() for c in self.children)})"

tree = Composite()
branch = Composite()
branch.add(Leaf())
branch.add(Leaf())
tree.add(branch)
tree.add(Leaf())
print(tree.operation())

```
* **Decorator** is a structural pattern that lets you attach new behaviors to objects by placing these objects inside special wrapper objects that contain the behaviors.
```python
class Coffee:
    def cost(self):
        return 5

class MilkDecorator:
    def __init__(self, coffee):
        self.coffee = coffee

    def cost(self):
        return self.coffee.cost() + 2

coffee = Coffee()
milk_coffee = MilkDecorator(coffee)
print(f"Cost of coffee with milk: {milk_coffee.cost()}")

```
* **Facade** is a structural pattern that provides a simplified interface to a library, a framework, or any other complex set of classes. The facade encapsulates the complexity of the subsystem, providing a single, easy-to-use start() method
```python
class CPU:
    def freeze(self):
        return "CPU freeze"

    def jump(self, position):
        return f"CPU jump to {position}"

    def execute(self):
        return "CPU execute"

class Memory:
    def load(self, position, data):
        return f"Memory load {data} at {position}"

class ComputerFacade:
    def __init__(self):
        self.cpu = CPU()
        self.memory = Memory()

    def start(self):
        return [
            self.cpu.freeze(),
            self.memory.load("0x00", "BOOT"),
            self.cpu.jump("0x00"),
            self.cpu.execute()
        ]

def main():
    computer = ComputerFacade()
    print("\n".join(computer.start()))

if __name__ == "__main__":
    main()
```
* **Flyweight** is a structural pattern that lets you fit more objects into the available amount of RAM by sharing common parts of state between multiple objects instead of keeping all of the data in each object.
```python
class Character:
    def __init__(self, char):
        self.char = char

class CharacterFactory:
    _characters = {}

    @classmethod
    def get_character(cls, char):
        if char not in cls._characters:
            cls._characters[char] = Character(char)
        return cls._characters[char]

def main():
    factory = CharacterFactory()
    c1 = factory.get_character('a')
    c2 = factory.get_character('a')
    print(f"Same character object: {c1 is c2}")
# The output will show that c1 and c2 are indeed the same object, demonstrating the memory-saving benefit of the Flyweight pattern.

if __name__ == "__main__":
    main()
```
* **Proxy** is a structural pattern that lets you provide a substitute or placeholder for another object. A proxy controls access to the original object, allowing you to perform something either before or after the request gets through to the original object.
```python
class RealSubject:
    def request(self):
        return "RealSubject: Handling request"

class Proxy:
    def __init__(self, real_subject):
        self._real_subject = real_subject

    def request(self):
        return f"Proxy: {self._real_subject.request()}"
# In this example, the Proxy adds a simple message before calling the RealSubject's method, demonstrating how it can intercept and modify the behavior of the RealSubject.

def main():
    real_subject = RealSubject()
    proxy = Proxy(real_subject)
    print(proxy.request())

if __name__ == "__main__":
    main()
```
## Behavioral Patterns
* **Chain of Responsibility** is a behavioral pattern that lets you pass requests along a chain of handlers. Upon receiving a request, each handler decides either to process the request or to pass it to the next handler in the chain. The Chain of Responsibility pattern allows passing requests along a chain of handlers. Each handler decides either to process the request or to pass it to the next handler in the chain.
```python
class Handler:
    def __init__(self, successor=None):
        self._successor = successor

    def handle_request(self, request):
        pass

class ConcreteHandler1(Handler):
    def handle_request(self, request):
        if request == "one":
            return "Handler1: Handling request"
        elif self._successor:
            return self._successor.handle_request(request)

def main():
    handler = ConcreteHandler1()
    print(handler.handle_request("one"))

if __name__ == "__main__":
    main()
```
* **Command** is a behavioral pattern that turns a request into a stand-alone object that contains all information about the request.
```python
class Command:
    def execute(self):
        pass

class Light:
    def turn_on(self):
        return "Light is on"

    def turn_off(self):
        return "Light is off"

class TurnOnCommand(Command):
    def __init__(self, light):
        self._light = light

    def execute(self):
        return self._light.turn_on()

def main():
    light = Light()
    command = TurnOnCommand(light)
    print(command.execute())

if __name__ == "__main__":
    main()
```
* **Interpreter** is a behavioral pattern that defines a grammatical representation for a language and provides an interpreter to deal with this grammar.
```python
class Expression:
    def interpret(self, context):
        pass

class TerminalExpression(Expression):
    def __init__(self, data):
        self._data = data

    def interpret(self, context):
        return self._data in context

def main():
    context = "Hello World"
    expression = TerminalExpression("World")
    print(expression.interpret(context))

if __name__ == "__main__":
    main()
```
* **Iterator** is a behavioral pattern that lets you traverse elements of a collection without exposing its underlying representation.
```python
class Iterator:
    def __init__(self, collection):
        self._collection = collection
        self._index = 0

    def next(self):
        result = self._collection[self._index]
        self._index += 1
        return result

    def has_next(self):
        return self._index < len(self._collection)

def main():
    collection = [1, 2, 3]
    iterator = Iterator(collection)
    while iterator.has_next():
        print(iterator.next())

if __name__ == "__main__":
    main()
```
* **Mediator** is a behavioral pattern that lets you reduce chaotic dependencies between objects. The pattern restricts direct communications between the objects and forces them to collaborate only via a mediator object.
```python
class Mediator:
    def notify(self, sender, event):
        pass

class ConcreteMediator(Mediator):
    def __init__(self, component1, component2):
        self._component1 = component1
        self._component2 = component2

    def notify(self, sender, event):
        if sender == self._component1:
            return f"Mediator reacts on {event} and triggers component2"
        return f"Mediator reacts on {event} and triggers component1"

class BaseComponent:
    def __init__(self, mediator=None):
        self._mediator = mediator

class Component1(BaseComponent):
    def do_a(self):
        return self._mediator.notify(self, "A")

class Component2(BaseComponent):
    def do_b(self):
        return self._mediator.notify(self, "B")

def main():
    c1 = Component1()
    c2 = Component2()
    mediator = ConcreteMediator(c1, c2)
    c1._mediator = mediator
    c2._mediator = mediator
    print(c1.do_a())

if __name__ == "__main__":
    main()
```
* **Memento** is a behavioral pattern that lets you save and restore the previous state of an object without revealing the details of its implementation.
```python
class Memento:
    def __init__(self, state):
        self._state = state

    def get_state(self):
        return self._state

class Originator:
    def __init__(self, state):
        self._state = state

    def save(self):
        return Memento(self._state)

    def restore(self, memento):
        self._state = memento.get_state()

    def get_state(self):
        return self._state

def main():
    originator = Originator("Initial state")
    memento = originator.save()
    originator._state = "Modified state"
    originator.restore(memento)
    print(originator.get_state())

if __name__ == "__main__":
    main()
```
* **Observer** is a behavioral pattern that lets you define a subscription mechanism to notify multiple objects about any events that happen to the object they're observing.
```python
class Subject:
    def __init__(self):
        self._observers = []

    def attach(self, observer):
        self._observers.append(observer)

    def notify(self):
        for observer in self._observers:
            observer.update()

class Observer:
    def update(self):
        pass

class ConcreteObserver(Observer):
    def update(self):
        return "Observer updated"

def main():
    subject = Subject()
    observer = ConcreteObserver()
    subject.attach(observer)
    print(subject.notify())

if __name__ == "__main__":
    main()
```
* **State** The State pattern allows an object to alter its behavior when its internal state changes. It's useful for implementing state machines, where an object's behavior changes based on its state without using large conditionals.

```python
class State:
    def handle(self):
        pass

class ConcreteStateA(State):
    def handle(self):
        return "State A handling"

class ConcreteStateB(State):
    def handle(self):
        return "State B handling"

class Context:
    def __init__(self, state):
        self._state = state

    def set_state(self, state):
        self._state = state

    def request(self):
        return self._state.handle()

context = Context(ConcreteStateA())
print(context.request())
context.set_state(ConcreteStateB())
print(context.request())

```
