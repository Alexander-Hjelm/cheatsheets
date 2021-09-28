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
   * [Files](git.md#files)
      * [Check out an individual file from another branch](git.md#check-out-an-individual-file-from-another-branch)
      * [Remove a checked in file (.gitignore accepts a file even though it shouldn't)](git.md#remove-a-checked-in-file-gitignore-accepts-a-file-even-though-it-shouldnt)
   * [Submodules](git.md#submodules)
   * [Solve a merge conflict](git.md#solve-a-merge-conflict)
      * [Solve manually](git.md#solve-manually)
      * [ours/theirs](git.md#ourstheirs)
   * [git rebase](git.md#git-rebase)
      * [Interactive](git.md#interactive)

<!-- Added by: runner, at: Tue Sep 28 09:11:40 UTC 2021 -->

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

## Submodules

When pulling a repository with submodules, do the following to initalize and update the submodules (with the --recursive option)
```bash
git submodule update --init --recursive
```

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
