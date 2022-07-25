Setting up a new branch
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

Git commit history
```
git log
```


Squash and rebase
```
## first way (A)
git rebase master
git rebase --continue
git log --oneline -10
git reset --soft HEAD~3 && git commit
git push --force

## second way (J)
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
