# GitHub CLI
<!--ts-->
<!--te-->

## Upon first installation

```powershell
gh auth login
gh auth refresh -s project
```

## Issue

### List

```powershell
gh issue list -a "@me"
```

### Create

```powershell
gh issue create -t "title" -b "body" -p "Managed Services" -a "@me"
gh issue create -t "title" -p "Managed Services" -a "@me"
```

## PR

```powershell
gh pr create -h -t "title" -a "@me"
gh pr merge 101
```
