# git
<!--ts-->
* [git](git.md#git)
   * [Init a bare repository](git.md#init-a-bare-repository)
   * [Remotes](git.md#remotes)
      * [View remotes](git.md#view-remotes)
      * [Add a remote](git.md#add-a-remote)
      * [Remove a remote](git.md#remove-a-remote)

<!-- Added by: runner, at: Fri Jul 16 08:25:13 UTC 2021 -->

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
