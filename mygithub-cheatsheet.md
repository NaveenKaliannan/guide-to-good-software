Configuring your /home/naveen/.gitconfig and /my-repository/.git. For example, user id, password
```
git config
```
Setting up a new branch
```
git branch new-branch-name
```
Status checks
```
git branch -v
git status
```
restore the files
```
git checkout filename
git restore filename
```
Update the current code
```
git pull
```
Checking out the created branch or master
```
git checkout new-branch-name
git checkout master
```
coping a specific commit from one branch to the interested branch
```
git checkout interested-branch
git cherrypick SHA-values-of-commit
```
Git commit history
```
git log
```
Squash and rebase
## first way (A)
```
git rebase master
git rebase --continue
git log --oneline -10
git reset --soft HEAD~3 && git commit
git push --force
```
## second way (J)
```
git branch backup/current-branch-name
git checkout master or interested-branch-name
git pull
git status
in case if there is an Unmerged paths: git reset --hard origin/interested-branch-name or origin/master
git status
git checkout my-branch-name
git rebase master or interested-branch-name (not origin)
git abort
git checkout master or interested-branch-name (not origin)
git cherry-pick
git cherry-pick SHA-values-of-commit
git log
git checkout my-branch-name
git reset --hard master or interested-branch-name (not origin)
git log
git checkout master or interested-branch-name (not origin)
git reset --hard origin/master or interested-branch-name
git log
git checkout my-branch-name
git push --force-with-lease
```
##squash
```
git rebase -i master
do : first commit to reword (top) and other all to squash (below)
git rebase --continue
git log
```
Delete a specific commit 
```
git rebase -i master
do : delete the specific commit instead of squash or pick or other keywords. This means delete the entire line
git push --force-with-lease
```
Delete a branch 
```
git branch -d unwanted-branch-name
-d option will delete the branch locally and -D will force the branch to delete locally
git push
Deleting a branch remotely. Use the following command
git push origin --delete unwanted-branch-name
```

To avoid from the following errors: "smudge filter lfs failed" or "external filter 'git-lfs filter-process' failed"
```
git lfs install --skip-smudge
git clone repository-name
git lfs pull
git lfs install --force
```
How to igonre files For example, binaries, inputs of large size, external libraries 
```
go to root of your local git (repository-name/.gitigonre) and create gitignore file
touch .gitignore
inside the file
# ignore ALL .log .xyz, .o files
*.log, .xyz, .o
# ignore ALL files in ANY directory named temp
temp/
```
To see the git root directory or branch hsa values 
```
git rev-parse --show-toplevel
git rev-parse --git-dir
git rev-parse --branches
```
