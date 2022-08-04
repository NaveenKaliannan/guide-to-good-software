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
git checkout master or suitable branch
git pull
git status
in case if there is an Unmerged paths: git reset --hard origin/

git rebase master
git push --force-with-lease
```
##squash
```
git rebase -i master
first commit to reword (top) and other all to squash (below)
git rebase --continue
git log
```
To avoid from the following errors: "smudge filter lfs failed" or "external filter 'git-lfs filter-process' failed"
```
git lfs install --skip-smudge
git clone repository-name
git lfs pull
git lfs install --force
```
