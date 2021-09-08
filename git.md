# git
<!--ts-->
* [git](git.md#git)
   * [Init a bare repository](git.md#init-a-bare-repository)
   * [Remotes](git.md#remotes)
      * [View remotes](git.md#view-remotes)
      * [Add a remote](git.md#add-a-remote)
      * [Remove a remote](git.md#remove-a-remote)
   * [Files](git.md#files)
      * [Remove a checked in file (.gitignore accepts a file even though it shouldn't)](git.md#remove-a-checked-in-file-gitignore-accepts-a-file-even-though-it-shouldnt)
   * [Solve a merge conflict](git.md#solve-a-merge-conflict)
      * [Solve manually](git.md#solve-manually)
      * [ours/theirs](git.md#ourstheirs)

<!-- Added by: runner, at: Wed Sep  8 10:17:12 UTC 2021 -->

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

## Files

### Remove a checked in file (.gitignore accepts a file even though it shouldn't)
```bash
git rm --cached <file name>
git commit
```
Then save the file again for good measure.

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
