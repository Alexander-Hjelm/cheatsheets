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

<!-- Added by: runner, at: Mon Aug  2 15:37:21 UTC 2021 -->

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
