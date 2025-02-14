# Bazel

Bazel is an open-source build and test tool developed by Google for automating software builds and tests. 
It is designed to handle large-scale projects with multi-language dependencies and supports building software for different architectures and platforms.

## Installaing Bazel

* **Bazel-built image with Docker**: Bazel builds images without a running Docker daemon, while Docker requires its daemon for image building. Uses rules like container_image or oci_image to create container image tarballs directly. Creates a single tarball containing the entire container image, which can be loaded into Docker later.
1. Build the image tarball: `bazel build //:app_tarball`
2. Load it into Docker: `docker load < bazel-bin/app_tarball/tarball.tar`
3. Run the container: `docker run --rm app:latest5`
Note that the Docker daemon typically builds images using a Dockerfile and the docker build command. Stores images in its own format within its private filesystem. Can create tarballs of images using docker save, but this is not the default behavior. Note also that the **The Open Container Initiative (OCI) ensures that containers are portable and standardized, which allows them to run seamlessly across different environments, unlike "normal" containers that may face compatibility issues due to proprietary formats or vendor-specific implementations. Containers created using Docker rules can still face compatibility issues**

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
* **Macros** in Bazel are functions called from BUILD files that can instantiate rules. They are primarily used for encapsulation and code reuse of existing rules and other macros. Macros simplify BUILD files by abstracting away complex rule configurations.
Here's a simple example of a macro:
```python
def resize_image(name, src, width, height):
    native.genrule(
        name = name,
        srcs = [src],
        outs = [name + ".resized.png"],
        cmd = "convert $(location %s) -resize %dx%d $(location %s)" % (src, width, height, name + ".resized.png"),
        tools = ["@imagemagick//:convert"],
    )
```
This macro can be used in a BUILD file like this:
```python
load(":image_rules.bzl", "resize_image")

resize_image(
    name = "small_logo",
    src = "logo.png",
    width = 100,
    height = 100,
)
```
* **Rules_docker** is a set of Bazel build rules designed to simplify the process of working with Docker containers. It provides a way to build, manipulate, and manage Docker images directly within the Bazel build system, without relying on external Docker commands or tools. These rules allow developers to integrate containerized workflows into their Bazel builds efficiently and reproducibly. Unlike traditional Docker builds, rules_docker does not rely on a running Docker daemon. Instead, it constructs image tarballs directly, ensuring hermetic and reproducible builds.
1.  container_image, container_push, container_pull, rules_k8s
```python
load("@io_bazel_rules_docker//container:container.bzl", "container_image")

container_image(
    name = "my_app",
    base = "@io_bazel_rules_docker//file/base:debian",
    files = ["app.py"],
    cmd = ["python3", "app.py"],
)
```
```python
load("@io_bazel_rules_docker//container:container.bzl", "container_push")

container_push(
    name = "push_my_app",
    format = "Docker",
    image = ":my_app",
    registry = "gcr.io",
    repository = "my-project/my-app",
    tag = "latest",
)
```
```python
load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

container_pull(
    name = "java_base",
    registry = "gcr.io",
    repository = "distroless/java",
    digest = "sha256:deadbeef...",
)
```
* **Another example** Explanation of each command:
1. py_layer: This creates a layer containing specific Python dependencies. It helps in organizing and managing dependencies efficiently.
2. py3_image: This builds a Docker image with a Python 3 runtime. It includes the specified source files and layers, making it ready for containerization1.
3. container_image: This command builds the final Docker image. It uses the py3_image as a base and adds additional configurations like exposed ports and the command to run1.
4. container_push: This pushes the built image to a specified container registry. In this example, it's pushing to Google Container Registry (gcr.io)2.

To use these rules, you would typically run:
1. `bazel build :app_container` to build the Docker image.
2. `bazel run :app_container -- --norun` loads the image into the local Docker daemon1. This makes the image available for local use without running it. The image will be visible when you run docker images on your local machine
3. `bazel run :app_container` Run the container using Bazel
4. `docker run app:latest` Run the container using Docker.
5. `bazel build :app_container.tar` To build a Docker-loadable tarball
6. `docker load -i bazel-bin/path/to/app_container.tar` Then load it with docker.

1. **defs.bzl**
```python
# defs.bzl
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//python:image.bzl", "py3_image")
load("@io_bazel_rules_docker//python:py_layer.bzl", "py_layer")
load("@rules_pkg//pkg:tar.bzl", "pkg_tar")


# This defines a macro that takes parameters for creating a Python Docker image:
# name: Base name for the generated targets
# srcs: Source files to include
# main: Main Python file to run
# base: Base Docker image
# repository: Docker repository
# tag: Image tag

def create_python_image(name, srcs, main, base, repository, tag):
    # Creates a tarball of the source files, placing them in the /app directory of the image.
    pkg_tar(
        name = name + "_tar",
        srcs = srcs,
        package_dir = "/app",
    )

    #Builds a Python layer with the application files and dependencies specified in requirements.txt.
    py_layer(
        name = name + "_layer",
        deps = [":" + name + "_tar"],
        requirements = "requirements.txt",
    )

    # Creates a Python 3 Docker image, using the specified base image and including the Python layer created earlier.
    py3_image(
        name = name + "_image",
        base = base,
        layers = [":" + name + "_layer"],
        main = main,
    )

    # Finalizes the Docker image, setting the repository and tag for distribution.
    container_image(
        name = name + "_container",
        base = ":" + name + "_image",
        repository = repository,
        tag = tag,
    )
```
2. **BUILD file**
```python
# BUILD
load("//:defs.bzl", "create_python_image")

create_python_image(
    name = "app",
    srcs = ["app.py", "requirements.txt"],
    main = "app.py",
    base = "@python_base//image",
    repository = "example.com/myapp",
    tag = "v1.0",
)

py_binary(
    name = "run_app",
    srcs = ["app.py"],
)
```
3. **app.py**
```python
# app.py
def add(a, b):
    return a + b

def main():
    result = add(5, 3)
    print(f"The sum of 5 and 3 is: {result}")

if __name__ == "__main__":
    main()
```
**A simple python applicaiton**

To use these rules, you would typically run:
1. `bazel build :app_image` Build the OCI image
2. `bazel build :app_tarball` Build the OCI tarball. This creates a tarball of the OCI image, which can be used for distribution or loading into Docker.
3. `docker load < bazel-bin/app_tarball/tarball.tar`  This loads the built image into your local Docker daemon.
4. `docker run example.com/myapp:v1.0` Run the container using Docker
5. `bazel run :app_image` This builds the image, loads it into Docker, and runs a container in one command.
6. `bazel run :run_app` Run the Python script directly (not in a container). This builds and runs the Python application directly, not in a container.

All the files
1. defs.bzl
```python
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//python:image.bzl", "py3_image")
load("@io_bazel_rules_docker//python:py_layer.bzl", "py_layer")
load("@rules_pkg//pkg:tar.bzl", "pkg_tar")
load("@rules_python//python:defs.bzl", "py_library")

# This function defines a macro for creating a Python Docker image.
def create_python_image(name, srcs, main, deps, requirements, base, repository, tag):
    # Creates a Python library target, including all source files and dependencies.
    py_library(
        name = name + "_lib",
        srcs = srcs,
        deps = deps,
    )

    # Creates a tarball of the Python source files and library, placing them in the "/app" directory of the image.
    pkg_tar(
        name = name + "_py_tar",
        srcs = srcs + [name + "_lib"],
        package_dir = "/app",
    )

    # Creates a layer containing the Python dependencies specified in the requirements file. This is more efficient for managing Python dependencies in Docker images.
    py_layer(
        name = name + "_layer",
        deps = [":" + name + "_lib"],
        requirements = requirements,
    )

    # Creates a Python 3 Docker image, using the specified base image and including the Python source files and dependencies layers.
    py3_image(
        name = name + "_py_image",
        base = base,
        layers = [
            ":" + name + "_py_tar",
            ":" + name + "_layer",
        ],
        main = main,
    )

    # Finalizes the Docker image, setting the repository and command to run the main Python script.
    container_image(
        name = name + "_image",
        base = ":" + name + "_py_image",
        repository = repository,
        cmd = ["python3", "/app/" + main],
    )
```
2. BUILD
```python
load("//:defs.bzl", "create_python_image")

create_python_image(
    name = "app",
    srcs = ["app.py", "math_operations.py"],
    main = "app.py",
    deps = [
        "@pip//numpy",
    ],
    requirements = "requirements.txt",
    base = "@python_base//image",
    repository = "example.com/myapp",
    tag = "v1.0",
)

py_binary(
    name = "run_app",
    srcs = ["app.py", "math_operations.py"],
    deps = [
        "@pip//numpy",
    ],
)
```
3. app.py
```python
from math_operations import add

def main():
    result = add(5, 3)
    print(f"The sum of 5 and 3 is: {result}")

if __name__ == "__main__":
    main()
```
4. math_operations.py
```python
import numpy as np

def add(a, b):
    return np.add(a, b)
```
5. requirements.txt
```text
numpy==1.21.0
```


**A simple C++ applicaiton**

To use these rules, you would typically run:
1. `bazel build :app_image` Build the OCI image
2. `bazel build :app_tarball` Build the OCI tarball. This creates a tarball of the OCI image, which can be used for distribution or loading into Docker.
3. `docker load < bazel-bin/app_tarball/tarball.tar`  This loads the built image into your local Docker daemon.
4. `docker run example.com/myapp:v1.0` Run the container using Docker
5. `bazel run :app_image` This builds the image, loads it into Docker, and runs a container in one command.
6. `bazel run :run_app` Run the Python script directly (not in a container). This builds and runs the Python application directly, not in a container.

All the files
1. defs.bzl
```python
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//cc:image.bzl", "cc_image")
load("@rules_pkg//pkg:tar.bzl", "pkg_tar")
load("@rules_cc//cc:defs.bzl", "cc_binary")

def create_cpp_image(name, srcs, main, deps, base, repository, tag):
    cc_binary(
        name = name + "_bin",
        srcs = srcs,
        deps = deps,
    )

    pkg_tar(
        name = name + "_bin_tar",
        srcs = [":" + name + "_bin"],
        package_dir = "/app",
    )

    cc_image(
        name = name + "_cc_image",
        base = base,
        binary = ":" + name + "_bin",
    )

    container_image(
        name = name + "_image",
        base = ":" + name + "_cc_image",
        repository = repository,
        tag = tag,
    )
```
2. BUILD
```python
load("//:defs.bzl", "create_cpp_image")

create_cpp_image(
    name = "app",
    srcs = ["main.cpp", "math_operations.cpp", "math_operations.h"],
    main = "main.cpp",
    deps = [],
    base = "@cc_base//image",
    repository = "example.com/myapp",
    tag = "v1.0",
)

cc_binary(
    name = "run_app",
    srcs = ["main.cpp", "math_operations.cpp", "math_operations.h"],
    deps = [],
)
```
3. main.cpp
```cpp
#include "math_operations.h"
#include <iostream>

int main() {
    int result = add(5, 3);
    std::cout << "The sum of 5 and 3 is: " << result << std::endl;
    return 0;
}
```
4. math_operations.cpp
```cpp
#include "math_operations.h"

int add(int a, int b) {
    return a + b;
}
```
5. math_operations.h
```cpp
#ifndef MATH_OPERATIONS_H
#define MATH_OPERATIONS_H

int add(int a, int b);

#endif
```

* **rules_oci** is a Bazel plugin for building OCI-compliant container images. Interoperability and running in different environments are key advantages of rules_oci

**A simple python applicaiton**

To use these rules, you would typically run:
1. `bazel build :app_image` Build the OCI image
2. `bazel build :app_tarball` Build the OCI tarball. This creates a tarball of the OCI image, which can be used for distribution or loading into Docker.
3. `docker load < bazel-bin/app_tarball/tarball.tar`  This loads the built image into your local Docker daemon.
4. `docker run example.com/myapp:v1.0` Run the container using Docker
5. `bazel run :app_image` This builds the image, loads it into Docker, and runs a container in one command.
6. `bazel run :run_app` Run the Python script directly (not in a container). This builds and runs the Python application directly, not in a container.

All the files
1. defs.bzl
```python
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_tarball")
load("@rules_pkg//pkg:tar.bzl", "pkg_tar")
load("@rules_python//python:defs.bzl", "py_library")

def create_python_image(name, srcs, main, deps, requirements, base, repository, tag):
    # This creates a Python library target. It includes all the source files (srcs) and dependencies (deps) of your Python project. This is useful for organizing your code and dependencies.
    py_library(
        name = name + "_lib",
        srcs = srcs,
        deps = deps,
    )

    # This creates a tarball containing all your Python source files and the library target created earlier. It packages these files into a directory named "/app" within the tarball.
    pkg_tar(
        name = name + "_py_tar",
        srcs = srcs + [name + "_lib"],
        package_dir = "/app",
    )

    # This creates a separate tarball for your requirements.txt file, also placing it in the "/app" directory.
    pkg_tar(
        name = name + "_req_tar",
        srcs = [requirements],
        package_dir = "/app",
    )
    # This combines the Python files tarball and the requirements tarball into a single tarball.
    pkg_tar(
        name = name + "_combined_tar",
        tars = [
            ":" + name + "_py_tar",
            ":" + name + "_req_tar",
        ],
    )

    # This creates the OCI (Open Container Initiative) image. It uses the specified base image, adds the combined tarball, and sets an entrypoint that first installs the requirements and then runs the main Python script.
    oci_image(
        name = name + "_image",
        base = base,
        tars = [":" + name + "_combined_tar"],
        entrypoint = [
            "/bin/sh",
            "-c",
            "pip install -r /app/requirements.txt && python3 /app/" + main,
        ],
        cmd = [],
    )

    # This creates a tarball of the OCI image, which can be easily distributed or loaded into Docker. It includes the specified repository and tag information.
    oci_tarball(
        name = name + "_tarball",
        image = ":" + name + "_image",
        repo_tags = [repository + ":" + tag],
    )
```
2. BUILD
```python
load("//:defs.bzl", "create_python_image")

# macro to define the build targets for our application. It specifies the source files, main Python file, base image, repository, and tag for the image.
create_python_image(
    name = "app",
    srcs = ["app.py", "math_operations.py"],
    main = "app.py",
    deps = [
        "@pip//numpy",
    ],
    requirements = "requirements.txt",
    base = "@python_base",
    repository = "example.com/myapp",
    tag = "v1.0",
)

# The py_binary rule allows running the Python script directly with Bazel.
py_binary(
    name = "run_app",
    srcs = ["app.py", "math_operations.py"],
    deps = [
        "@pip//numpy",
    ],
)
```
3. app.py
```python
from math_operations import add

def main():
    result = add(5, 3)
    print(f"The sum of 5 and 3 is: {result}")

if __name__ == "__main__":
    main()
```
4. math_operations.py
```python
import numpy as np

def add(a, b):
    return np.add(a, b)
```
5. requirements.txt
```text
numpy==1.21.0
```

**A simple C++ applicaiton**

To use these rules, you would typically run:
1. `bazel build :app_image` Build the OCI image
2. `bazel build :app_tarball` Build the OCI tarball. This creates a tarball of the OCI image, which can be used for distribution or loading into Docker.
3. `docker load < bazel-bin/app_tarball/tarball.tar`  This loads the built image into your local Docker daemon.
4. `docker run example.com/myapp:v1.0` Run the container using Docker
5. `bazel run :app_image` This builds the image, loads it into Docker, and runs a container in one command.
6. `bazel run :run_app` Run the Python script directly (not in a container). This builds and runs the Python application directly, not in a container.

All the files
1. defs.bzl
```python
load("@rules_oci//oci:defs.bzl", "oci_image", "oci_tarball")
load("@rules_pkg//pkg:tar.bzl", "pkg_tar")
load("@rules_cc//cc:defs.bzl", "cc_binary")

def create_cpp_image(name, srcs, main, deps, base, repository, tag):
    cc_binary(
        name = name + "_bin",
        srcs = srcs,
        deps = deps,
    )

    pkg_tar(
        name = name + "_bin_tar",
        srcs = [":" + name + "_bin"],
        package_dir = "/app",
    )

    oci_image(
        name = name + "_image",
        base = base,
        tars = [":" + name + "_bin_tar"],
        entrypoint = ["/app/" + name + "_bin"],
        cmd = [],
    )

    oci_tarball(
        name = name + "_tarball",
        image = ":" + name + "_image",
        repo_tags = [repository + ":" + tag],
    )
```
2. BUILD
```python
load("//:defs.bzl", "create_cpp_image")

create_cpp_image(
    name = "app",
    srcs = ["main.cpp", "math_operations.cpp", "math_operations.h"],
    main = "main.cpp",
    deps = [],
    base = "@cc_base//image",
    repository = "example.com/myapp",
    tag = "v1.0",
)

cc_binary(
    name = "run_app",
    srcs = ["main.cpp", "math_operations.cpp", "math_operations.h"],
    deps = [],
)
```
3. main.cpp
```cpp
#include "math_operations.h"
#include <iostream>

int main() {
    int result = add(5, 3);
    std::cout << "The sum of 5 and 3 is: " << result << std::endl;
    return 0;
}
```
4. math_operations.cpp
```cpp
#include "math_operations.h"

int add(int a, int b) {
    return a + b;
}
```
5. math_operations.h
```cpp
#ifndef MATH_OPERATIONS_H
#define MATH_OPERATIONS_H

int add(int a, int b);

#endif
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
### Here’s a simple example of using alias, config_setting, bool_flag, and exports_files in Bazel to configure a math-related project.
`bazel build //:math_app` and `bazel run //:math_app`
* Workspace structure
```text
math_project/
├── WORKSPACE
├── BUILD
├── flags.bzl
├── add.cc
├── multiply.cc
├── main.cc
└── config.json
```
1. **WORKSPACE**
The WORKSPACE file is empty for this example, as no external dependencies are required.
2. **BUILD**
```python
load("@bazel_skylib//rules:common_settings.bzl", "bool_flag")
load(":flags.bzl", "bool_flag_with_settings")

# Define a boolean flag to choose between addition and multiplication
bool_flag(
    name = "use_multiplication",
    build_setting_default = False,  # Default is addition
)

# Create config settings for true/false values of the flag
bool_flag_with_settings(name = "use_multiplication")

# Alias target to select the correct math implementation
alias(
    name = "math_lib",
    actual = select({
        ":use_multiplication_true": ":multiply_lib",  # Use multiplication if flag is true
        "//conditions:default": ":add_lib",          # Default to addition
    }),
)

# Define the addition library
cc_library(
    name = "add_lib",
    srcs = ["add.cc"],
)

# Define the multiplication library
cc_library(
    name = "multiply_lib",
    srcs = ["multiply.cc"],
)

# Export a configuration file (e.g., for runtime settings)
exports_files(["config.json"])
```
2. **BUILD** Another version
```python
cc_binary(
    name = "math_app",
    srcs = ["main.cc", "add.cc", "multiply.cc"],
    data = ["config.json"],  # Include config.json in the runfiles
)
```
3. **flags.bzl**
This file defines a helper macro to create config_setting targets for boolean flags.
```python
def bool_flag_with_settings(name):
    native.config_setting(
        name = name + "_true",
        flag_values = {
            ":" + name: "True",  # When the flag is true
        },
    )
    native.config_setting(
        name = name + "_false",
        flag_values = {
            ":" + name: "False",  # When the flag is false
        },
    )
```
4. **add.cc** This C++ file implements addition.
```cpp
#include <iostream>

void calculate() {
    int a = 3, b = 5;
    std::cout << "Addition result: " << (a + b) << std::endl;
}
```
5. **multiply.cc** This C++ file implements multiplication.
```cpp
#include <iostream>

void calculate() {
    int a = 3, b = 5;
    std::cout << "Multiplication result: " << (a * b) << std::endl;
}
```
6. **config.json** This is an example configuration file that could be used at runtime.
```json
{
    "operation": "multiplication",  // Can be "addition" or "multiplication"
    "author": "example_user"
}
```
7. main.cc
```cpp
#include <iostream>
#include <fstream>
#include <string>
#include <nlohmann/json.hpp>  // Include a JSON library like nlohmann/json

// Declare calculate() functions from add.cc and multiply.cc
void calculate_add();
void calculate_multiply();

int main() {
    // Read config.json
    std::ifstream config_file("config.json");
    if (!config_file) {
        std::cerr << "Error: Could not open config.json" << std::endl;
        return 1;
    }

    // Parse JSON content
    nlohmann::json config;
    config_file >> config;

    // Get the operation type from config.json
    std::string operation = config["operation"];
    std::cout << "Operation selected: " << operation << std::endl;

    // Perform the appropriate calculation based on the operation
    if (operation == "addition") {
        calculate_add();
    } else if (operation == "multiplication") {
        calculate_multiply();
    } else {
        std::cerr << "Error: Unknown operation '" << operation << "'" << std::endl;
        return 1;
    }

    return 0;
}
```
Explanation
* Boolean Flag (bool_flag): The use_multiplication flag determines whether to use addition or multiplication. Default value is False, so addition is used unless overridden.
* Config Settings (config_setting): The flags.bzl file defines two settings: one for when the flag is True and another for when it’s False.
* Alias (alias): The math_lib alias dynamically selects either add_lib or multiply_lib, depending on the value of the flag.
* Exported File (exports_files): The config.json file is made available for other targets to depend on or package with binaries.
Building and Running
* Build with Addition (Default):
```bash
bazel build //:math_lib
```
Output:
```text
Addition result: 8
```
* Build with Multiplication:
```bash
bazel build //:math_lib --//:use_multiplication=True
```
Output:
```text
Multiplication result: 15
```
* Exported File:
The config.json file can now be included in packaging or used by other targets.
* Summary
This example demonstrates how you can use Bazel's features:
**bool_flag**: To define a build-time configuration option.
**config_setting**: To create conditions based on the value of the flag.
**alias**: To dynamically select between two libraries based on configuration.
**exports_files**: To make non-source files (like JSON configs) available in your build system.
This approach allows you to write flexible and configurable builds while keeping your workspace clean and organized!
###  A simple example of how to build and run a Docker image using Bazel:
1. Set up your Bazel workspace:
In your WORKSPACE file, add:
```python
# This line loads the http_archive rule from a Bazel-internal repository (@bazel_tools).
# The http_archive rule is a Bazel built-in function used to download and extract external dependencies packaged as archives (like .tar.gz or .zip files) from remote locations.
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# This line uses the http_archive rule to declare and download the rules_docker repository as an external dependency.
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.25.0/rules_docker-v0.25.0.tar.gz"],
)

# This line loads the container_repositories function from the repositories.bzl file within the newly downloaded rules_docker repository.
load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)
# This line calls the container_repositories function. This function is responsible for setting up other repositories that rules_docker depends on (a form of dependency management within rules_docker). It effectively defines a set of other external dependencies required by rules_docker to function correctly. These might include specific versions of libraries or other tools.

container_repositories()

# This line loads the deps function from deps.bzl file within rules_docker.
load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

# This line calls the container_deps function. This function likely sets up toolchains and/or performs other configuration steps necessary for rules_docker to work. It might define things like the versions of Docker that are supported or set up the build environment for creating Docker images.
container_deps()
```
2. Create a BUILD file:
```python
load("@io_bazel_rules_docker//container:container.bzl", "container_image")

container_image(
    name = "my_image",
    base = "@docker_debian//:debian_bullseye",
    cmd = ["echo", "Hello from Docker!"],
)
```
3. Build the Docker image:
```bash
bazel build //:my_image
```
4. Run the Docker image:
```bash
bazel run //:my_image
```
