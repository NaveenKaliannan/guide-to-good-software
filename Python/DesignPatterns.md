# Design Patterns in Python

## Class types
* **Superclass**: Parent class in inheritance hierarchy.
* **Subclass**: Child class inheriting from a superclass.
* **Abstract Class**: Cannot be instantiated, provides common interface.
* **Concrete Class**: Can be instantiated, implements abstract methods.
* **Interface**: Defines contract for implementing classes.
* **Builder Class**: Constructs complex objects step by step.
* **Factory Class**: Creates objects without specifying exact class.
* **Singleton Class**: Ensures only one instance exists.
* **Adapter Class**: Allows incompatible interfaces to work together.
* **Decorator Class**: Adds functionality to objects dynamically.
* **Observer Class**: Gets notified of changes in observed objects.
* **Strategy Class**: Defines family of interchangeable algorithms.
* **Proxy Class**: Controls access to another object.
* **Composite Class**: Treats individual and composite objects uniformly.
* **Iterator Class**: Provides way to access elements sequentially.
* **Command Class**: Encapsulates request as an object.
* **Facade Class**: Provides simplified interface to complex subsystem.
* **Prototype Class**: Creates new objects by cloning existing ones.
* **Memento Class**: Captures and restores object's internal state.
* **State Class**: Allows object to alter behavior when state changes.
* **Visitor Class**: Separates algorithm from object structure.
* **Mediator Class**: Reduces dependencies between objects.
* **Chain of Responsibility Class**: Passes request along chain of handlers.
* **Flyweight Class**: Minimizes memory use by sharing common data.
* **Interpreter Class**: Implements a specialized language.
* **Template Method Class**: Defines skeleton of algorithm in operations.
* **Bridge Class**: Separates abstraction from implementation.

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
* **Builder** is a creational pattern that lets you construct complex objects step by step. Builder class creates objects step by step. The Builder pattern allows for the construction of complex objects through a series of steps, typically implemented as methods in the builder class
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
# Existing system that works with Celsius
class CelsiusThermometer:
    def get_temperature(self):
        return 25.0  # Celsius temperature

# Incompatible system that uses Fahrenheit
class FahrenheitThermometer:
    def get_fahrenheit(self):
        return 77.0  # Fahrenheit temperature

# Adapter to make Fahrenheit thermometer work with Celsius interface
class FahrenheitAdapter(CelsiusThermometer):
    def __init__(self, fahrenheit_thermometer):
        self.fahrenheit_thermometer = fahrenheit_thermometer
    
    def get_temperature(self):
        fahrenheit = self.fahrenheit_thermometer.get_fahrenheit()
        return (fahrenheit - 32) * 5/9  # Convert to Celsius

# Client code
def display_temperature(thermometer):
    celsius = thermometer.get_temperature()
    print(f"The temperature is {celsius:.1f}°C")

# Usage
celsius_thermometer = CelsiusThermometer()
fahrenheit_thermometer = FahrenheitThermometer()
adapter = FahrenheitAdapter(fahrenheit_thermometer)

display_temperature(celsius_thermometer)  # Output: The temperature is 25.0°C
display_temperature(adapter)              # Output: The temperature is 25.0°C
# This example shows how the Adapter pattern allows us to use a Fahrenheit thermometer in a system designed for Celsius, without changing the existing code.
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
* **Decorator** is a structural pattern that lets you attach new behaviors to objects by placing these objects inside special wrapper objects that contain the behaviors. Wrapping objects: It wraps the original object with decorator objects that add new behaviors or modify existing ones. Runtime modification: Decorators can be added or removed at runtime, allowing for flexible object enhancement without altering the original class structure.
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


class TextProcessor:
    def process(self, text):
        return text

class UppercaseDecorator:
    def __init__(self, processor):
        self.processor = processor

    def process(self, text):
        return self.processor.process(text).upper()

class BoldDecorator:
    def __init__(self, processor):
        self.processor = processor

    def process(self, text):
        return f"<b>{self.processor.process(text)}</b>"

# Usage
simple_processor = TextProcessor()
uppercase_processor = UppercaseDecorator(simple_processor)
bold_uppercase_processor = BoldDecorator(uppercase_processor)

text = "Hello, World!"
print(simple_processor.process(text))  # Output: Hello, World!
print(uppercase_processor.process(text))  # Output: HELLO, WORLD!
print(bold_uppercase_processor.process(text))  # Output: <b>HELLO, WORLD!</b>

```
* **Facade** is a structural pattern that provides a simplified interface to a library, a framework, or any other complex set of classes. The facade encapsulates the complexity of the subsystem, providing a single, easy-to-use start() method. The  Facade class provides a simplified interface to use these components. Facade pattern simplifies the usage of a complex system by providing a higher-level interface

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

# Complex subsystem components
class DVDPlayer:
    def on(self):
        print("DVD player is on")
    def play(self, movie):
        print(f"Playing {movie}")

class Amplifier:
    def on(self):
        print("Amplifier is on")
    def set_volume(self, level):
        print(f"Amplifier volume set to {level}")

class Projector:
    def on(self):
        print("Projector is on")
    def set_input(self, input):
        print(f"Projector input set to {input}")

# Facade
class HomeTheaterFacade:
    def __init__(self):
        self.dvd = DVDPlayer()
        self.amp = Amplifier()
        self.projector = Projector()

    def watch_movie(self, movie):
        print("Get ready to watch a movie...")
        self.dvd.on()
        self.amp.on()
        self.amp.set_volume(5)
        self.projector.on()
        self.projector.set_input("DVD")
        self.dvd.play(movie)

# Client code
home_theater = HomeTheaterFacade()
home_theater.watch_movie("Inception")
# The Facade pattern is particularly useful when dealing with complex systems or libraries that have many interdependent classes or when the source code is unavailable1. By introducing this simplified interface, the Facade pattern helps manage complexity, reduces coupling, and makes client applications more manageable and less error-prone, especially in large and complex projects.
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
* **Command** is like creating a "remote control" for your code. The Command pattern is a behavioral design pattern that encapsulates a request or action as an object. In the Command pattern, the command objects typically don't directly get input from the user. Instead, they encapsulate a specific action or request, along with any necessary parameters, that were determined when the command was created.
 The Command pattern is particularly useful in scenarios requiring undo/redo functionality, queueing or scheduling of operations, remote execution of commands, macro recording and playback, and implementing transactional systems. It's also valuable for decoupling the requester of an operation from the object performing it, allowing for more flexible and extensible software design, especially in GUI frameworks and game development where complex sequences of actions need to be managed.
```python
# Undo/Redo (Text editor):

class TextEditor:
    def __init__(self):
        self.text = ""
        self.history = []

    def type(self, text):
        self.history.append(self.text)
        self.text += text

    def undo(self):
        if self.history:
            self.text = self.history.pop()

editor = TextEditor()
editor.type("Hello")
editor.type(" World")
editor.undo()  # Reverts to "Hello"

# Macro reading

class Macro:
    def __init__(self):
        self.commands = []

    def record(self, command):
        self.commands.append(command)

    def play(self):
        for command in self.commands:
            command()

macro = Macro()
macro.record(lambda: print("Step 1"))
macro.record(lambda: print("Step 2"))
macro.play()  # Prints: Step 1 \n Step 2


# Remote Execution
class RemoteControl:
    def execute(self, command):
        print(f"Executing remote command: {command}")

class TVRemote:
    def __init__(self):
        self.remote = RemoteControl()

    def turn_on(self):
        self.remote.execute("TV_ON")

tv_remote = TVRemote()
tv_remote.turn_on()  # Prints: Executing remote command: TV_ON


# Queuing

from queue import Queue

class PrintSpooler:
    def __init__(self):
        self.queue = Queue()

    def add_job(self, document):
        self.queue.put(document)

    def print_next(self):
        if not self.queue.empty():
            print(f"Printing: {self.queue.get()}")

spooler = PrintSpooler()
spooler.add_job("Document1.pdf")
spooler.add_job("Document2.pdf")
spooler.print_next()  # Prints: Printing: Document1.pdf


# Scheduling (Simple scheduler):

import time

class Scheduler:
    def __init__(self):
        self.tasks = []

    def add_task(self, task, delay):
        self.tasks.append((task, time.time() + delay))

    def run(self):
        while self.tasks:
            task, scheduled_time = self.tasks[0]
            if time.time() >= scheduled_time:
                task()
                self.tasks.pop(0)

scheduler = Scheduler()
scheduler.add_task(lambda: print("Task 1"), 2)
scheduler.add_task(lambda: print("Task 2"), 1)
scheduler.run()

``` 
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

from abc import ABC, abstractmethod

# Command interface
class Command(ABC):
    @abstractmethod
    def execute(self):
        pass

# Concrete Commands
class LightOnCommand(Command):
    def __init__(self, light):
        self.light = light

    def execute(self):
        self.light.turn_on()

class LightOffCommand(Command):
    def __init__(self, light):
        self.light = light

    def execute(self):
        self.light.turn_off()

# Receiver
class Light:
    def turn_on(self):
        print("Light is on")

    def turn_off(self):
        print("Light is off")

# Invoker
class RemoteControl:
    def __init__(self):
        self.command = None

    def set_command(self, command):
        self.command = command

    def press_button(self):
        self.command.execute()

# Client code
light = Light()
light_on = LightOnCommand(light)
light_off = LightOffCommand(light)

remote = RemoteControl()

remote.set_command(light_on)
remote.press_button()  # Output: Light is on

remote.set_command(light_off)
remote.press_button()  # Output: Light is off

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
* **Observer** is a behavioral pattern that lets you define a subscription mechanism to notify multiple objects about any events that happen to the object they're observing. The Observer pattern facilitates communication between objects by establishing a one-to-many relationship between a subject (observable) and multiple observers
```python
class WeatherStation:
    def __init__(self):
        self._observers = []
        self._temperature = 0

    def register_observer(self, observer):
        self._observers.append(observer)

    def remove_observer(self, observer):
        self._observers.remove(observer)

    def notify_observers(self):
        for observer in self._observers:
            observer.update(self._temperature)

    def set_temperature(self, temp):
        self._temperature = temp
        self.notify_observers()

class DisplayDevice:
    def update(self, temperature):
        pass

class PhoneDisplay(DisplayDevice):
    def update(self, temperature):
        print(f"Phone display: The temperature is {temperature}°C")

class TabletDisplay(DisplayDevice):
    def update(self, temperature):
        print(f"Tablet display: Current temp is {temperature}°C")

# Usage
weather_station = WeatherStation()
phone = PhoneDisplay()
tablet = TabletDisplay()

weather_station.register_observer(phone)
weather_station.register_observer(tablet)

weather_station.set_temperature(25)
weather_station.set_temperature(30)
# This demonstrates how the Observer pattern allows multiple objects (displays) to be notified of changes in another object (weather station) without tight coupling between them.
```
* **Strategy pattern** is a behavioral design pattern that allows selecting an algorithm at runtime1. It enables defining a family of algorithms, encapsulating each one, and making them interchangeable34. This pattern provides flexibility to choose the right strategy for a task dynamically, similar to selecting the most suitable tool from a toolbox3
```
from abc import ABC, abstractmethod

# Strategy interface
class Strategy(ABC):
    @abstractmethod
    def execute(self) -> str:
        pass

# Concrete strategies
class ConcreteStrategyA(Strategy):
    def execute(self) -> str:
        return "Executing Strategy A"

class ConcreteStrategyB(Strategy):
    def execute(self) -> str:
        return "Executing Strategy B"

# Context class
class Context:
    def __init__(self, strategy: Strategy = None):
        self._strategy = strategy

    def set_strategy(self, strategy: Strategy):
        self._strategy = strategy

    def execute_strategy(self) -> str:
        if self._strategy:
            return self._strategy.execute()
        return "No strategy set"

# Usage
context = Context()
context.set_strategy(ConcreteStrategyA())
print(context.execute_strategy())  # Output: Executing Strategy A

context.set_strategy(ConcreteStrategyB())
print(context.execute_strategy())  # Output: Executing Strategy B


from abc import ABC, abstractmethod
from typing import List, Union

# Strategy interface
class SummationStrategy(ABC):
    @abstractmethod
    def sum(self, data: List[Union[int, float]]) -> Union[int, float]:
        pass

# Concrete strategies
class IntegerSummation(SummationStrategy):
    def sum(self, data: List[Union[int, float]]) -> int:
        return sum(int(x) for x in data)

class FloatSummation(SummationStrategy):
    def sum(self, data: List[Union[int, float]]) -> float:
        return sum(float(x) for x in data)

# Context class
class DatasetSummer:
    def calculate_sum(self, data: List[Union[int, float]]) -> Union[int, float]:
        strategy = IntegerSummation() if all(isinstance(x, int) for x in data) else FloatSummation()
        return strategy.sum(data)

# Usage
if __name__ == "__main__":
    dataset_summer = DatasetSummer()

    integer_data = [1, 2, 3, 4, 5]
    float_data = [1.1, 2.2, 3.3, 4.4, 5.5]
    mixed_data = [1, 2.5, 3, 4.7, 5]

    print(f"Integer sum: {dataset_summer.calculate_sum(integer_data)}")
    print(f"Float sum: {dataset_summer.calculate_sum(float_data)}")
    print(f"Mixed sum: {dataset_summer.calculate_sum(mixed_data)}")

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
