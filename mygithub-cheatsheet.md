

Creating a new branch

```
git branch new-branch-name
```
Status checks
```
git branch -v
git status
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
Squash and rebase
```
git rebase master
git push --force-with-lease
git rebase -i master
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
