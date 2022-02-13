 # git
<!--ts-->
* [git](git.md#git)
   * [Init a bare repository](git.md#init-a-bare-repository)
   * [Remotes](git.md#remotes)
      * [View remotes](git.md#view-remotes)
      * [Add a remote](git.md#add-a-remote)
      * [Remove a remote](git.md#remove-a-remote)
   * [push / pull](git.md#push--pull)
      * [Push to another branch in the remote](git.md#push-to-another-branch-in-the-remote)
   * [git reset](git.md#git-reset)
   * [git stash](git.md#git-stash)
      * [Stash untracked files](git.md#stash-untracked-files)
      * [Wkrk with specific stashes](git.md#wkrk-with-specific-stashes)
   * [Files](git.md#files)
      * [Check out an individual file from another branch](git.md#check-out-an-individual-file-from-another-branch)
      * [Remove a checked in file (.gitignore accepts a file even though it shouldn't)](git.md#remove-a-checked-in-file-gitignore-accepts-a-file-even-though-it-shouldnt)
   * [git filter-repo](git.md#git-filter-repo)
      * [Split a git repo and preserve history](git.md#split-a-git-repo-and-preserve-history)
   * [Submodules](git.md#submodules)
      * [Initialize](git.md#initialize)
      * [Update a submodule](git.md#update-a-submodule)
      * [push to a submodule](git.md#push-to-a-submodule)
   * [Solve a merge conflict](git.md#solve-a-merge-conflict)
      * [Solve manually](git.md#solve-manually)
      * [ours/theirs](git.md#ourstheirs)
   * [git rebase](git.md#git-rebase)
      * [Interactive](git.md#interactive)
      * [Use rebase to rewrite a branch on top of another](git.md#use-rebase-to-rewrite-a-branch-on-top-of-another)
   * [Branches](git.md#branches)
      * [Delete a local branch](git.md#delete-a-local-branch)
         * [Delete all branches except one](git.md#delete-all-branches-except-one)
      * [Rename a branch](git.md#rename-a-branch)
      * [I accidentally pushed to the wrong branch](git.md#i-accidentally-pushed-to-the-wrong-branch)
   * [git grep](git.md#git-grep)
      * [search for keyword in commit history](git.md#search-for-keyword-in-commit-history)
   * [Troubleshooting](git.md#troubleshooting)
      * [Filename too long, '$GIT_DIR' too big](git.md#filename-too-long-git_dir-too-big)
      * [Error in submodule when checking out a branch.](git.md#error-in-submodule-when-checking-out-a-branch)

<!-- Added by: runner, at: Sun Feb 13 12:05:26 UTC 2022 -->

<!--te-->

## Init a bare repository
```bash
git init --bare
```

## Remotes

### View remotes
```bash
git remote -v
```

### Add a remote
```bash
git remote add origin https://github.com/gittower/example.git
```

### Remove a remote
```bash
git remote rm <remote-name>
```

## push / pull

### Push to another branch in the remote

To push the changes to a remote branch with a different name: 
```bash
git push origin localBranchName:remoteBranchName
```

## git reset
Reset to a previous commit, deleting the new commit.

```bash
git reset --mixed HEAD~1
```

Can be used with the following strategies:
```bash
--soft: uncommit changes, changes are left staged (index).
--mixed (default): uncommit + unstage changes, changes are left in working tree.
--hard: uncommit + unstage + delete changes, nothing left.
```

## git stash

```bash
git stash save
git checkout otherbranch
git stash apply
```

### Stash untracked files
```bash
git stash save -u
```

### Wkrk with specific stashes

```bash
git stash list
git stash show stash@{1}     # Show a summary of a specific stash
git stash apply stash@{1}    # Apply a specific stash
git stash drop stash@{1}     # Drop a specific stash
git stash pop stash@{1}      # Apply and drop a specific stash
```

If no stash is speciifed, the latest stash will be pointed to.

## Files

### Check out an individual file from another branch
```bash
git checkout <branch name> <file name>
```


### Remove a checked in file (.gitignore accepts a file even though it shouldn't)
```bash
git rm --cached <file name>
git commit
```
Then save the file again for good measure.

## git filter-repo

### Split a git repo and preserve history
```bash
pip install git-filter-repo
cd git-repo-root
git filter-repo --subdirectory-filter subdir/ --force
```

## Submodules

### Initialize

When pulling a repository with submodules, do the following to initalize and update the submodules (with the --recursive option)
```bash
git submodule update --init --recursive
```

### Update a submodule
Starting from the higher level repo, do:
```bash
cd submodule
git pull
git checkout <tag/commit id>
cd ..
git add .
git commit -m "Update submodule XXX to v. YYY"
git push
```

### push to a submodule

If a submodule is initialized under your repo, that submodule will have its own .git-folder. You can cd into the submodule and push to/pull from it as usual.

## Solve a merge conflict

### Solve manually

Let's take the following example:

```bash
<<<<<<< HEAD
this is some content to mess with
content to append
=======
totally different content to merge later
>>>>>>> new_branch_to_merge_later
```

Here you would remove either the **HEAD** block (content in the master branch):
```bash
<<<<<<< HEAD
this is some content to mess with
content to append
=======
```

Or the **new_branch_to_merge_later** the HEAD block (content in the branch that we are merging from):
```bash
=======
totally different content to merge later
>>>>>>> new_branch_to_merge_later
```

Make sure to remove all the "fluff", including the lines:
- <<<<<<< HEAD
- =======
- \>\>\>\>\>\>\> new_branch_to_merge_later

Finally save your file and run `git add <file name>`

Reference: https://www.atlassian.com/git/tutorials/using-branches/merge-conflicts

### ours/theirs

For simpler merge conflicts where you know which version of the file to use, run:
- `git checkout --ours <file name>` to use the master (HEAD) version
- `git checkout --theirs <file name>` to use the new_branch_to_merge_later version

Finally run `git add <file name>`

## git rebase

Git rebase can be used to change the commit history after a branch has been commited or pushed. It can be used to e.g. rename, reorder, squash or remove specific commits.

### Interactive

To edit all commits up until a specific commit (exclusive, the last comit is not included):

```bash
git rebase --i <commit id>
```

Alternatively, to edit the last 3 commits, you can do:

```bash
git rebase --i HEAD~3
```

The interactive screen will look something like this:

```bash
pick 8d3fc77 Add greeting.txt
pick 2a73a77 Add farewell.txt
pick 0b9d0bb fixup greeting.txt

# Rebase f5f19fb..0b9d0bb onto f5f19fb (3 commands)
#
# Commands:
# p, pick <commit> = use commit
# f, fixup <commit> = like "squash", but discard this commit's log message
```

For each commit you can change the **pick** statement to do something else. Here is a list of the useful commands:

- **p, pick**: use commit, leave the commit unchanged.
- **r, reword**: edit the commit message
- **e, edit**: use commit, but stop for amending
- **s, squash**: Squash the commit into the previous commit
- **f, fixup**: like squash but keep only the previous commit's message
- **x, exec**: run command (the rest of the line) using shell
- **b, break*: stop here (continue rebase later with 'git rebase --continue')
- **d, drop**: remove commit

**Fun fact**: You can also change the order of the commits by reordering the lines.

Finally, save the file and exit to start the rebase. You may encounter merge conflicts, which can be solved manually or simply by the "ours" strategy to get the latest changes.

To push the changes to a remote branch and overwrite the remote contents: 
```bash
git push origin localBranchName:remoteBranchName --force
```

### Use rebase to rewrite a branch on top of another
```
git checkout -b feature/test_new_components_backup           # Branch backup
git checkout feature/test_new_components                     # Checkout the branch again
git fetch origin                                             # Get latest changes
git rebase C10                                               # Start rebase

# For every merge conflict, add the files and continue:

git add .\source\application\app_gps.c 
git rebase –continue

git push --force
```

## Branches

### Delete a local branch
```bash
git branch -d <local-branch>      # Normal
git branch -D <local-branch>      # Force
```

#### Delete all branches except one
In bash:
```bash
git branch | grep -v "branch-to-keep" | xargs git branch -D 
```

### Rename a branch
```bash
git branch -m old-name new-name
```

### I accidentally pushed to the wrong branch

We must reset our changes (using the --mixed strategy to keep our local changes after the reset), then check out the correct branch and commit there.

```bash
git reset --mixed HEAD~1
git checkout -b newbranch
git add .
git commit -m "My commit message"
git commit -m "Committed on new branch"
```

## git grep

### search for keyword in commit history
```bash
git grep search_string $(git rev-list --all)
```

## Troubleshooting

### Filename too long, '$GIT_DIR' too big

Enable longpaths via: 
```bash
git config --system core.longpaths true
```

If that doesn't work, open regedit and set the registry key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem\LongPathsEnabled` to 1.

### Error in submodule when checking out a branch.

When checking out another branch, and a submodule has conflicts. Sometimes it can help to set ’recursive = false’ in .gitconfig, and the do the checkout. Remember to set it back afterwards.
