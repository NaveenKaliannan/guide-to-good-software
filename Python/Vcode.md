# Visual Studio Code

## Important Files one needs to be aware of it
* **$HOME/.vscode/extensions/<extension-name>/<version>/settings.json** file for Visual Studio Code extensions is typically located in the extension's directory within the VS Code extensions folder. The file in Visual Studio Code serves as a configuration file that allows users to customize and control various aspects of the editor's behavior and appearance. 

## Commands
* **code --version** Displays the version of Visual Studio Code installed on your system. 
* **code** Launches Visual Studio Code.
* **code filename** Opens the specified file in Visual Studio Code.
* **code folder** Opens the specified folder in Visual Studio Code
* **Ctrl + F** to search inside a file
* **Ctrl + Shift + F** to search across all files
* **Ctrl + P** to search for a file

## Interface
### Explorer
* **File > Open Folder** Select the folder you want to open, and its contents will appear in the Explorer view/
* **Cloning Repository** copy a remote Git repository (e.g., from GitHub) to your local machine and open it in VS Code.
* **Explorer > New File or New Folder** or **Command line to create a file or folder** to create a new file and folder in the repository or source code.
* **File > Close Folder** will close the opened folder.

 ### Extensions
 * **Open the Extensions View, Search for the Python Extension, Install the Extension**
 * **Locate the Installed Extension, Disable the Extension (You can choose to disable it globally or just for your current workspace), Disable Linting (Optional)**
 ```text
# Open settings.json

"python.linting.enabled": false
``` 
 * **Locate the Installed Extension, Uninstall the Extension, Manually Remove Residual Files (Optional):**
 ```text
%USERPROFILE%\.vscode\extensions
``` 

