# Git and Github
******************************************
 Git is a popular version control system that runs on local machine.  GitHub is a cloud-based hosting service that helps to manage git repositories.

## Git installation
******************************************
* **command line** `sudo apt-get update`  and `sudo apt-get install git`. CLI provides the most control and power
* **GUI installations** `sudo apt-get install git-gui`, `git gui` and `gitk` or `sudo apt-get install git-all`
* **gitk**  This is a repository browser tool for visualizing the commit history.
* **git-gui** This provides a GUI for performing Git commands like commit, push, pull etc.
* **git --version** shows the version of git
* **git-scm.com** for git documentation.
* **ssh key** provide a more secure way of authenticating.  `ssh-keygen -f remote-key` with passphrase or `ssh-keygen -t rsa -b 4096 -f ./id_rsa -N ''` without passphrase creates both public (`remote-key.pub`) and private key (`remote-key`). This key pair inside the `remote-key.pub` can then be used for secure authentication instead of password-based authentication. The private key is used by the client to prove its identity to the server. The public key is used by the server to verify the client's identity based on the digital signature created with the private key. The private key never leaves your local machine, eliminating the risk of password sniffing or brute-force attacks.
  1. Copy the public key content to the file `~/.ssh/authorized_keys` 
  2. `chmod 700 ~/.ssh` and `chmod 600 ~/.ssh/authorized_keys`
  3. `ssh -i /home/naveenk/.ssh/id_rsa username@hostaddress`  
* **ssh agent** like a manager who stores keys, passphrase and used for authentication purposes. Start the SSH agent: `eval "$(ssh-agent -s)"`, Add the key to the agent: `ssh-add ~/.ssh/id_rsa  # Replace with your actual key path if different`, Verifying Key Addition: `ssh-add -l`. Connecting to a Machine: `ssh user@remote_machine_address` The SSH agent typically runs for your current shell session. You can set it to start automatically at login by adding the `eval "$(ssh-agent -s)"` command to your shell configuration file .bashrc. **SSH Agent:** Acts as a secure vault that stores your private SSH keys in memory. The agent creates the socket in a temporary location on your system.  **SSH Agent Socket:* Provides a secure communication channel between the SSH client and the agent. **SSH Client Program (e.g., ssh):** Initiates the connection to the remote machine. It interacts with the SSH agent socket to request access to your private key for authentication. When you run an SSH command, the client program connects to the socket. The agent verifies your identity (often by asking for your key passphrase). If verification is successful, the agent provides the key to the client program, allowing passwordless login to the remote machine.
 
## Terminology
******************************************
* **repository** is the complete project and metadata stored by Git, including all commits, branches, and file versions.
* **HEAD->master** means the pointer refer to the current location in master. **git switch branch-name** switches to give branch. Then the pointer refer to the given branch **HEAD->branch-name**. **git checkout commitID** switches to an commit. Now the pointer refer to the commit. **cat .git/HEAD** reference particular commit **Commit hash value**. 
* **origin** means cloud. **origin/branch-name** means branch in cloud. **branch-name** means branch in local machine.
* **detached HEAD** not in the tip of the branch but in a specific commit.
* **Git uses SHA-1** to hash the files, folders, commits and etc. The SHA-1 hashing funciton takes input data or values and provides the hash keys as an output. Example Hash Key for `Naveen Kumar Kaliannan` is `f8007b9a9d497d67fe67f6cfb441b8f86f085d5e`. **echo 'Naveen Kumar Kaliannan' | git hash-object --stdin** shows the key, **git cat-file -p  'ca0f485d1b190b8f0945ebbb6529a6b46bbd21b6'** shows the value. **git hash-object file or folder or text** gives the key. 

## Important difference in commands
******************************************
* **Git Merge** : When you merge one branch into another, Git creates a new commit that combines the changes from both branches. This new commit has two parent commits, one from each of the merged branches.
```bash
# Start on the main branch
git checkout main

# Merge the feature branch into main
git merge feature

# The commit history now looks like:
#   C4 (HEAD -> main) Merge branch 'feature'
#  /\
# C2 C3 (feature) Feature commits
# |/
# C1 Initial commit
```
**Git Rebase** : Rebase rewrites the commit history of one branch onto another. It moves the entire branch to begin on the tip of the target branch, replaying each commit from the source branch onto the target one. Unlike merge, rebasing doesn't create new merge commits. Instead, it linearizes the history, making it appear as if the work on the rebased branch occurred directly after the work on the branch it's rebased onto.
```bash
# Start on the feature branch
git checkout feature

# Rebase the feature branch onto main
git rebase main

# The commit history now looks like:
#   C3' (HEAD -> feature) Feature commit
#   C2' Feature commit
#  /
# C1 (main) Initial commit
```
* **git fetch**  only downloads new data from the remote repository (such as new branches or updated commits) to your local repository. It doesn't integrate these changes into your working branches or modify your working directory. After fetching, you can inspect the changes and decide how to integrate them into your local branches, such as by merging or rebasing. 
```bash
# Check the current state of your local repository
cat example.txt  # Output: Hello, World!

# Fetch the changes from the remote repository
git fetch

# The changes are now in your local repository, but not merged
git log --oneline origin/main  # Shows the new commit from the remote

# Your local working directory is still unchanged
cat example.txt  # Output: Hello, World!

# To merge the changes, you need to explicitly run `git merge`
git merge origin/main

# Now the changes are merged into your local working directory
cat example.txt  # Output: Hello, Universe!
```
**git pull** is a combination of two actions: git fetch followed by git merge or git rebase.
```bash
# Check the current state of your local repository
cat example.txt  # Output: Hello, World!

# Pull the changes from the remote repository
git pull

# The changes are automatically fetched and merged
cat example.txt  # Output: Hello, Universe!
```
* The **git reset --hard** command is a destructive operation that moves the branch pointer to a specified commit, discarding all changes made after that commit.
* The **git revert** command is a safer way to undo changes. It creates a new commit that undoes the changes made by a specified commit, leaving the commit history intact
  
## Important file you should know about in git
******************************************
* `.git` directory
1. **description:** This is a text file that contains a description of the repository. It's typically used for informational purposes.
2.  **refs:** This directory contains references to commits, branches, and tags in the repository. It's used to keep track of the current state of the repository.
3.  **hooks:** This directory contains custom scripts that can be executed at different stages of the Git workflow, such as before a commit, after a push, etc. The **pre-commit hook** script runs before the commit is created, allowing you to prevent the commit if certain conditions such unit test cases are not sucess. The post-commit hook runs after the commit is created, allowing you to perform actions that should happen after the commit, such as notifications or deployments.
4.  **HEAD:** This is a symbolic reference that points to the current branch or commit in the repository. **cat .git/HEAD** reference particular commit **ref: ref/head/branch-name**. 
5. **branches:** This directory contains files that represent the local branches in the repository.
6. **objects:** This directory stores all the objects (commits, trees, blobs) that make up the repository's history.
7.  **config:** This is the main configuration file for the Git repository. It contains settings like the repository's remote URL, user information, and other customizations. 
* The primary purpose of `.gitkeep` is to force Git to include an otherwise empty directory in the repository. Without a file inside, Git would ignore the directory entirely
* `.gitignore` file ignore the files and directories that should not be part of commit.
```gitignore
# 1. Ignore a specific file
example.txt

# 2. Ignore all files with .log extension
*.log

# 3. Ignore all files in the "temp" directory
temp/

# 4. Ignore all files starting with "test"
test*

# 5. Ignore all files named "debug.log" in any directory
**/debug.log

# 6. Ignore all .txt files except example.txt
*.txt
!example.txt

# 7. Ignore all files except README.md
*
!README.md

# 8. Ignore files in the "build" directory but not its subdirectories
/build/

# 9. Ignore all files named "config.json" in any directory
**/config.json

# 10. Ignore files in the root directory only
/*
```
* **.gitattributes** - Git's control to suit various file types and workflow requirements within your repository. By specifying attributes in this file, Git stores files and folders based on the defined rules and configurations.
```gitignore
It has structure of pattern attr1 attr2 .. inside the file

```text
# Set default behaviour to automatically normalize line endings
* text=auto

# Force Unix-style line endings for these file types
*.js text eol=lf
*.css text eol=lf
*.html text eol=lf

# Force Windows-style line endings for batch scripts
*.bat text eol=crlf

# Treat these files as binary and don't generate diffs
*.png binary
*.jpg binary

# Diff these files with external tools
*.doc diff=word
*.pdf diff=pdf

# Use the union merge driver for these files
*.unity3d merge=unityyamlmerge
*.prefab merge=unityyamlmerge

# Ensure Unix line endings in exported archives
* text=auto eol=lf export-ignore

# Track Unity3D asset files in LFS
*.unity3d filter=lfs diff=lfs merge=lfs -text
*.prefab filter=lfs diff=lfs merge=lfs -text

# Treat these as Python source files
*.py diff=python
```

## Git configuration
******************************************
* To configure your Git user settings, you can use the **git config** command.
Here's how you can set your user name and email for all Git repositories on your system (global configuration) or for a specific repository:
```bash
git config --global user.name  "NaveenKaliannan"
git config user.name
git config --global user.email "myemailaddress"
git config --global user.email
git config --global core.editor "vim"
git config --global core.editor
git config --global alias.s  status
git s
```
The configuration can be seen in /home/naveenk/.gitconfig.  git alias are helpful to reduce the commands [alias] s=status, l=log
```bash
git config --local user.name  "NaveenKaliannan"
git config user.name
git config --local user.email "myemailaddress"
git config --local user.email
git config --local core.editor "vim"
git config --local core.editor
```
The configuration can be seen .git/config.
* Set up SSH authentication by generating an SSH key pair and adding the public key to your GitHub account. Configuring SSH keys is important for accessing credentials for the SSH network protocol. This allows you to connect to a remote repository without needing to type a password.
To create a new key on your local machine: Navigate to the .ssh/ directory: 
```bash
cd ~/.ssh/
```
List the contents of the directory to check for existing keys:
```bash
ls -ltr
```
Copy the content of the public key id_rsa.pub:
```bash
cat id_rsa.pub
```
Paste the copied content into the SSH keys section of your GitHub account settings: Go to Settings -> SSH and GPG keys  Click on "New SSH key" and paste the copied key
* To generate a new SSH key: Run the following command to generate an RSA key with a bit length of 4096:
```bash
ssh-keygen -t rsa -b 4096
```
* Verify SSH Connection: You can verify that your SSH connection is working by running:
```bash
ssh -T git@github.com
```
use the SSH URL for your Git remote instead of the HTTPS URL.


## Git commands
******************************************
* **git init** creates a hidden .git subdirectory in the current working directory. This directory contains all the necessary files and directories for a Git repository. git init for already exisining repo will not create new repo
* **git add file1 file2** selects the interested changes to the staging area for commit. Untracked files in red will be left out for commit. **git commit -m (--message) "commit message"** creates a checkpoint or snapshot with commit message. Note that **git add .** adds all untracked files. The commit should focus on single topics such single bug fix. The commit message should be in *past tense* and meaningful. When commit is made, hash unique long/letter number (SHA1 alogirthm) is created with other commit information. The inital commit will not have a parent commit. 
* **git log** shows the commit information such usernmae, Hash values, date commit message and etc.
* **git log --pretty=oneline --abbrev-commit** shows the commit in prettier way.
* **git commit --amend** amending the previous commit.
* **git status** shows which branch, commit status, untracked file, staged files and etc.
* **git branch branch-name** HEAD will refer to master, branch-name both.\
      1. **master** is the default branch. It is an **official branch**. Recently the **master** is named to **main** in github not in git.\
      2. **git branch -v** shows all the branches and tippest commit name. **git branch -r** shows all the remote branch.\
      3. **git switch branch-name** switches to given branch. Then the HEAD pointer refers to the branch-name. **git switch -c branch-name** creates a new branch and switches to it.\
      4. **git checkout branch-name** switches to given branch.\
      5. **git branch -d unwanted-branch-name** -d option will delete the branch locally and -D will force the branch to delete locally. **git push** push the change.\
      6. **git push origin --delete unwanted-branch-name** Deleting a branch remotely. Note that one cannot delete the branch by checking out.\
      7. **git branch -m new-branch-name** renames the branch to new name.\
      8. For **Merging** the changes from a side branch to master or branch of interest, we need to switch to master or branch of interest. **git swtich master or branch-of-interest**, i.e., HEAD->master or branch-of-interest. Then **git merge side-branch**, i.e., HEAD->master or branch-of-interest. Commits from side-branch will appended into master. \
      9. **Fast Forward Merging** happens only when the side branch is ahead of master and there is no commit on master after side branch is created and commited.  \
      10. when the **master is ahead of the side-branch**, **git switch master** and **git merge side-branch** will merge but the git will make additional commit with commit message 'merge brach side-branch'. \
      11. **git diff** shows the difference between commits, branches, files,  specific files and etc. **git diff commit1..commit2 textfile.txt** shows the difference between textfile in commit1 and textfile in commit2. **git diff --staged** compares the staging area with the last commit. **git diff** shows the unstaged changes. **git diff HEAD** compares the staged and unstaged changes with last commit. **git diff branch1..branch2** compares 2 branches. **git diff --stat** shows the stats. `@@ -<old_line>,<old_lines_count> +<new_line>,<new_lines_count> @@` The starting line number in the "old" (original) version of the file, and the number of lines of context.  The starting line number in the "new" (modified) version of the file, and the number of lines of context. `@@` means hunk header which tells about location and context of the changes.\
      12.  **git stash** saves the uncommited work and brings back. **git stash pop** brings the stashed work to working directory again. This allows to switch branches without making commits to changes. **git stash apply** will keep the stashes in stash and can be applied multiple time. \
      13. **Multiple stash** **git stash list** and **git stash apply stash@{1}** reference particular stash inside the curly braces. **git stash drop stash@{1}** drops the particular stash inside the curly braces. **git stash pop** always consides the last stash.\  
      14. **Conflict markers** Resolve the conflict by choosing which changes to keep.       Get rid of those markers and unwanted changes. Then **git add changes** and **git commit -m "resolve conflicts"** fix the issue.
  
      <<<<<<< HEAD
      This is the content on the main branch. Updated by you.
      =======
      This is the content on the feature branch.
      >>>>>>> side-branch

* **git log --pretty=oneline --abbrev-commit** and **git checkout commit-hash-value** checkouts the old commit.\
* **git checkout origin/branch-name** checkouts the origin branch in local machine.
* **git checkout HEAD~1** checkouts one commit before. **git checkout HEAD~2** checkouts two commit before. **git checkout HEAD~5** checkouts five commit before. **git switch -** brings back to tip.
* **git checkout HEAD filename** checkouts the file from last commit. \
* **git restore filename** restores the file from HEAD with committed change. It is an alternative for **git checkout HEAD filename**.  **git restore --source HEAD~2 filename** restore the file from 2 commits ago.
* **git restore --staged filename** to unstage the files.
* **git reset commit-hash** get rid of the commit, there wont be any commit after that. But the changes will still be present. This can be used later or commited. 
* **git reset --hard commit-hash** removes the commit and the latest changes will also be removed.
* **git revert commit-hash** it will undo the commit by making a new commit. The commit that we want to remove will still exist. 
* Pick commit and copy to another branch: Checkout the branch you want to apply the commit to : **git checkout interested-branch** and Use the git cherry-pick command, providing the commit SHA (hash value) of the commit you want to copy: **git cherry-pick SHA-of-commit**
* **Resolving conflicts during rebase** :exclamation: If there are any conflicts, you'll need to resolve them manually. Once the conflicts are resolved, add the files and continue the rebase: **git add .**,  **git rebase --continue**, and **git log**
* **git clean -d -f** is used to remove untracked files from the working directory of a Git repository, including directories (-d) and force-deleting (-f) them.


## Github commands
******************************************
* **git clone URL** copies the latest git reposity from cloud.\
* **shallow clone**The error message "RPC error: TLS connection" typically indicates an issue with the SSL/TLS connection during a Git operation. To address this error and complete the repository cloning process, you can follow these steps : Clone the repository with the --depth 1 option to limit the history depth (called shalled clone): **git clone --depth 1 git-link**, **cd git-name**, Fetch the complete history of the repository to resolve the shallow clone **git fetch --unshallow**. Here the `--depth 1` This option specifies that only the most recent commit and its associated data will be cloned.  
* **git push origin branch-name** pushes master or given branch to cloud or origin  \
* **git push origin sidebranch:masterbranch** push the latest changes from side-branch to origin master\
* **git push -u or --set-upstream origin branch-name** command is used to set the upstream branch for the current local branch. This means that it establishes a relationship between your local branch and a branch on a remote repository. The upstream means that you can use commands like git push and git pull without specifying the remote and branch names explicitly \
* **git fetch origin branch-name** brings the origin/branch-name and will update the origin/branch-name but branch-name will be unaffected. git status on branch-name will say my branch is behind certain commits.
* **git pull origin branch-name** is sum of **git fetch** and **git merge**. If conflicts, then **git add changes** and **git commit -m "resolve conflicts"** fix the issue.
* **pull request** in GitHub is a core feature that enables developers to propose and discuss changes to a codebase before merging them into the main project

* **Squash and Rebase** :exclamation: to maintain workflows. Squashing commits is a way to combine multiple commits into a single commit: **git checkout your-branch**, then **git rebase -i master**, In the text editor, you'll see the word "pick" next to each commit. Change the word "pick" to "squash" (or "s" for short) for all the commits you want to squash, except for the first one. For the first commit, you can leave it as "pick" or change it to "reword" if you want to modify the commit message. If there are any conflicts, you'll need to resolve them manually. Once the conflicts are resolved, add the files and continue the rebase: **git add .**,  **git rebase --continue**, and **git log**
* **Delete a specific commit**  can delete a specific commit **git checkout your-branch**, then **git rebase -i master** In the text editor, locate the commit you want to delete. Instead of using "pick" or "squash", simply delete the entire line for the commit you want to remove or add `drop`. Then **git push --force-with-lease**
* **Delete a specific commit in main branch** Identify the commit you want to delete **git log** Take note of the commit's SHA (the unique identifier for the commit). **git rebase -i <commit-sha>~1** Replace <commit-sha> with the SHA of the commit you want to delete. The **~1** means you want to rebase the last commit before the one you specified. Then **git push --force-with-lease**
* **interactive rebase** opens an interactive rebase editor **git rebase -i HEAD~3** specifies that you want to rebase the last 3 commits, i.e., the commits that are 3 steps back from the current HEAD commit.
* **git reset --soft HEAD~3 && git commit** reset the HEAD to 3rd commit, but keep the changes since it is soft reset. Then changes are commited in single commit. 

* **git reflog** shows a log that records when the tips of branches and other references were updated in the local repository. Reflogs expire 90 days.\
* **git reflog show HEAD** shows HEAD reference
* **git reset HEAD** is for undoing uncommitted changes. **git reflog** is rescue to **git reset**
* To prevent encountering errors such as "smudge filter lfs failed" or "external filter 'git-lfs filter-process' failed," follow these steps: **git lfs install --skip-smudge**, **git clone repository-name**, **git lfs pull**, **git lfs install --force**
* To see the git root directory or branch hsa values : **git rev-parse --show-toplevel**, **git rev-parse --git-dir**, **git rev-parse --branches**
* To update your local branch with the latest changes from the remote repository and reset the head pointer to the latest commit, you can follow these steps: **git checkout master**, **git pull**, **git reset --hard origin/branch-name**, and **git pull**
* To resolve the error indicating an incomplete merge (MERGE_HEAD exists), follow these steps: **git merge --abort**, **git fetch --all**, **git branch -v**, **git reset --hard origin/branch-name**, and **git pull**.

## Git Tags
**********************************
* Version the code at important points with three digits **3.8.1**, i.e., **major releases.minor releases.patch releases**.
* **git tag** shows all tags.
* **git tag tagname**
* **git tag -a tagname** annotated tag
* **git tag tagname previous-commit** tag the previous commit
* **git tag -f tagname commit** move tag to another commit id from one commit
* **git tag -d tagname** deletes the tag
* **git push --tags** pushes the tag to cloud or origin
**********************************

## How to add note, warning, various symbols in Github Readme.md file 

> __Note__  

> __Warning__
:exclamation: for exclamation \
:warning: for warning \
:boom: for danger\
:memo: for general notes\
:point_up: for important points\
:zap: for special attention\

| :warning: WARNING          |
|:---------------------------|
| content   |

| :boom: DANGER              |
|:---------------------------|
| content |

| :memo:        | content       |
|---------------|:------------------------|

| :point_up:    | content |
|---------------|:------------------------|

| :exclamation:  content   |
|-----------------------------------------|

| :zap:        content   |
|-----------------------------------------|

Note that the &check; ( means Passed), &cross; (means not checked yet) and &cross; ( means Failed)

