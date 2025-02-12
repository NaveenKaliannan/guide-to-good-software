# Bazel

Bazel is an open-source build and test tool developed by Google for automating software builds and tests. 
It is designed to handle large-scale projects with multi-language dependencies and supports building software for different architectures and platforms.

## Installaing Bazel

## Important Keywords one should be aware
* **cc_binary**: rule in Bazel is used to define a C++ binary target, which compiles and links source files into an executable program. It is one of Bazel's built-in rules for C++ projects.
* **java_binary**: For Java executables
* **py_binary** : For Python executables
* **go_binary**: For Go executables
* **rust_binary**: For Rust executables
* **scala_binary**: For Scala executables
* **haskell_binary**: For Haskell executables
* **nodejs_binary** : For JavaScript/Node.js executables
* **objc_binary** : For Objective-C executables
* **sh_binary**: For shell script executables
* **name** : The name of the binary target. This is mandatory and uniquely identifies the target.
* **srcs** : A list of source files (e.g., .cc files) that are compiled to create the binary.
* **deps** : Specifies other targets (e.g., cc_library) that this binary depends on.
```python
cc_binary(
    name = "hello_world",
    srcs = ["hello_world.cc"],
    deps = [":greet_lib"],  # Depends on a library defined in the same BUILD file
)

#The target is named hello_world.
#The source file hello_world.cc is compiled.
#It depends on a library target named greet_lib.

# When you build this target using Bazel (e.g., bazel build :hello_world), Bazel:
# Compiles all the source files listed in srcs.
# Links them with any dependencies specified in deps.
# Produces an executable binary named hello_world.
```
```python
py_binary(
    name = "main",
    srcs = ["main.py"],
    deps = [
        "//utils:string_utils",  # Dependency on a py_library
        requirement("Flask"),    # External dependency from pip
    ],
)
```
* **WORKSPACE.bazel** This file defines the root of the workspace and external dependencies and **BUILD.bazel** This file defines build targets for the root package of the workspace
* `bazel build //:main` and `bazel run //:main`
```text
my_project/
├── WORKSPACE.bazel          # Root workspace file
├── BUILD.bazel              # Top-level package definition
├── src/
│   ├── BUILD.bazel          # Package definition for src/
│   ├── main.cc              # Source file
│   └── utils/
│       ├── BUILD.bazel      # Package definition for utils/
│       ├── helper.cc        # Source file
│       └── helper.h         # Header file

```
* workspace.bazel
```python
# WORKSPACE.bazel

# Declare the workspace name (optional but recommended)
workspace(name = "my_project")

# Load an external dependency (e.g., pybind11 for Python-C++ bindings)
http_archive(
    name = "pybind11",
    urls = ["https://github.com/pybind/pybind11/archive/refs/tags/v2.10.4.tar.gz"],
    strip_prefix = "pybind11-2.10.4",
)

# Load another dependency, e.g., Google Test for C++ testing
http_archive(
    name = "gtest",
    urls = ["https://github.com/google/googletest/archive/refs/tags/v1.13.0.tar.gz"],
    strip_prefix = "googletest-1.13.0",
)
```
* BUILD.bazel
```python
# BUILD.bazel (in the root directory)

# Define a C++ binary target that depends on code in the `src` package
cc_binary(
    name = "main",
    srcs = [],
    deps = ["//src:main_lib"],
)
```
* src/BUILD.bazel
```python
# src/BUILD.bazel

# Define a library target for the main application logic
cc_library(
    name = "main_lib",
    srcs = ["main.cc"],
    deps = ["//src/utils:helper_lib"],  # Depend on the utility library in utils/
)
```
* src/utils/BUILD.bazel
```python
# src/utils/BUILD.bazel

# Define a library target for utility functions
cc_library(
    name = "helper_lib",
    srcs = ["helper.cc"],
    hdrs = ["helper.h"],
)

```
* Example C++ Code
1. src/main.cc
```cpp
#include <iostream>
#include "src/utils/helper.h"

int main() {
    std::cout << "Sum of 3 and 5 is: " << add(3, 5) << std::endl;
    return 0;
}
```
2. src/utils/helper.cc
```cpp
#include "helper.h"

int add(int a, int b) {
    return a + b;
}
```
3. src/utils/helper.h
```cpp
#ifndef HELPER_H_
#define HELPER_H_

int add(int a, int b);

#endif  // HELPER_H_
```


## Important Commands
* **bazel build**: Builds the specified targets, compiling source code and generating output artifacts (e.g., binaries, libraries)135.
* **bazel run**: Builds and then runs the specified binary target (e.g., py_binary, cc_binary)124.
* **bazel test**: Builds and runs the specified test targets, reporting success or failure123.
* **bazel clean**: Removes all cached build outputs (useful for starting fresh)145.
* **bazel query**: Executes a dependency graph query to analyze relationships between targets145.
* **bazel aquery**: Queries the post-analysis action graph to inspect build actions147.
* **bazel cquery**: Queries the dependency graph with configurations applied (useful for multi-platform builds)145.
* **bazel fetch**: Fetches all external dependencies required by a target, downloading them if necessary145.
* **bazel info**: Displays runtime information about the Bazel server, such as output directories or workspace paths14.
* **bazel version**: Prints Bazel's version information14.
* **bazel analyze-profile**: Analyzes build profile data to identify performance bottlenecks in builds15.
* **bazel coverage**: Generates a code coverage report for the specified test targets45.
* **bazel mobile-install**: Installs built targets (e.g., Android apps) onto mobile devices for testing14.
* **bazel shutdown**: Stops the Bazel server, which can be useful for freeing resources or debugging server issues14.
* **bazel sync**: Synchronizes all repositories specified in the workspace file, ensuring dependencies are up-to-date47.
* **Relative Path and Absolute Path usage**
```text
WORKSPACE
my_project/
    BUILD
    main.py
    utils/
        BUILD
        helper.py
```
1. To build the target main in the root package (my_project/BUILD):
```bash
bazel build //my_project:main
```
2. To build a target helper in the utils/BUILD file:
```bash
bazel build //my_project/utils:helper
```
3. If you are inside my_project/utils/ and want to build the helper target: Relative Path
```bash
bazel build :helper
```
4.Absolute Path. Absolute labels (//...) are preferred for clarity and consistency, especially when working across multiple directories or packages
```bash
bazel build //my_project/utils:helper
```


## Examples of Bazel Build
 * **git clone https://github.com/bazelbuild/examples**
 
 ### A simple examples
* **Stage 1**: Basic setup with a single C++ file (main.cc) that uses a utility function from utils.cc.
* **Stage 2**: Adds another layer of functionality with math_utils.cc and its header file.
* **Stage 3**: Introduces Python files (main.py, string_utils.py, and math_utils.py) alongside the C++ files, demonstrating cross-language builds.

 ```text
example-project
├── stage1
│   ├── main
│   │   ├── BUILD
│   │   ├── main.cc
│   │   ├── utils.cc
│   │   └── utils.h
│   └── MODULE.bazel
├── stage2
│   ├── main
│   │   ├── BUILD
│   │   ├── main.cc
│   │   ├── utils.cc
│   │   ├── utils.h
│   │   ├── math_utils.cc
│   │   └── math_utils.h
│   └── MODULE.bazel
├── stage3
│   ├── cpp
│   │   ├── BUILD
│   │   ├── main.cc
│   │   ├── utils.cc
│   │   ├── utils.h
│   │   ├── math_utils.cc
│   │   └── math_utils.h
│   ├── python
│       ├── BUILD
│       ├── main.py
│       ├── string_utils.py
│       └── math_utils.py
└── MODULE.bazel
```
* stage1/main/BUILD (C++ Build Rules)
```python
cc_binary(
    name = "main",
    srcs = ["main.cc", "utils.cc"],
    deps = [],
)
```
* stage2/main/BUILD (C++ Build Rules)
```python
cc_binary(
    name = "main",
    srcs = ["main.cc", "utils.cc", "math_utils.cc"],
    deps = [],
)
```
* stage3/cpp/BUILD (C++ Build Rules)
```python
cc_library(
    name = "math_lib",
    srcs = ["math_utils.cc"],
    hdrs = ["math_utils.h"],
)

cc_binary(
    name = "main",
    srcs = ["main.cc", "utils.cc"],
    deps = [":math_lib"],
)
```
* stage3/python/BUILD (Python Build Rules)
```python
py_binary(
    name = "main_py",
    srcs = ["main.py", "string_utils.py", "math_utils.py"],
)
```
* stage1/main/main.cc
```cpp
#include "utils.h"

int main() {
    printMessage();
    return 0;
}

```
* stage1/main/utils.cc
```cpp
#include <iostream>
#include "utils.h"

void printMessage() {
    std::cout << "Hello from utils!" << std::endl;
}
```
* stage1/main/utils.h
```cpp
#ifndef UTILS_H_
#define UTILS_H_

void printMessage();

#endif  // UTILS_H_
```
* stage2/main/math_utils.cc
```cpp
#include <iostream>
#include "math_utils.h"

int add(int a, int b) {
    return a + b;
}
```
* stage2/main/math_utils.h
```cpp
#ifndef MATH_UTILS_H_
#define MATH_UTILS_H_

int add(int a, int b);

#endif  // MATH_UTILS_H_

```
* stage3/python/main.py
```python
from string_utils import greet_user

if __name__ == "__main__":
    greet_user("World")

```
* stage3/python/string_utils.py
```python
def greet_user(name):
    print(f"Hello, {name}!")

```
* stage3/python/math_utils.py
```python
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b
```

### Python files depending on the C++ files
`bazel build //:main` and `bazel run //:main` should run the command.
```python
# This line loads the pybind_extension rule from the pybind11_bazel repository.
# The pybind_extension rule is specifically designed to build Python extension modules using pybind11,
# a library that facilitates creating Python bindings for C++ code.
# This rule automatically handles necessary build flags and dependencies for pybind1136.
load("@pybind11_bazel//:build_defs.bzl", "pybind_extension")

# This rule creates a reusable C++ library that can be linked with other targets
cc_library(
    name = "cpp_lib",
    srcs = ["example.cpp"],
    hdrs = ["example.h"],
)

# This defines a Python extension module using pybind11.
# This rule compiles and links the specified source files into a shared object file (cpp_module.so) that can be imported as a Python module.
pybind_extension(
    name = "cpp_module",
    srcs = ["binding.cpp"],
    deps = [
        ":cpp_lib",
        "@pybind11//:pybind11",
    ],
)

# This defines a Python binary target.
# The py_binary rule creates an executable Python program that can use both pure Python code and compiled C++ functionality through pybind11 bindings.
py_binary(
    name = "main",
    srcs = ["main.py"],
    data = [":cpp_module.so"],
)
```
* example.cpp
```cpp
#include "example.h"

int add(int a, int b) {
    return a + b;
}

```
* example.h
```cpp
#ifndef EXAMPLE_H_
#define EXAMPLE_H_

int add(int a, int b);

#endif  // EXAMPLE_H_
```
* binding.cpp
```cpp
#include <pybind11/pybind11.h>
#include "example.h"

namespace py = pybind11;

PYBIND11_MODULE(cpp_module, m) {
    m.doc() = "A simple module that provides a C++ addition function";
    m.def("add", &add, "A function that adds two numbers");
}

```
* main.py
```python
import cpp_module

if __name__ == "__main__":
    result = cpp_module.add(3, 5)
    print(f"The result of adding 3 and 5 is: {result}")
``` 
