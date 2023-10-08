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
gh issue list -a "@me" --search "-label:blocked -label:review"
```

### Create

```powershell
gh issue create -t "title" -b "body" -p "Managed Services" -a "@me"
gh issue create -t "title" -p "Managed Services" -a "@me"
```

### Comment

```powershell
gh issue comment 215
```

## PR

```powershell
gh pr create -h -t "title" -a "@me"
gh pr merge 101
```

## Release

```powershell
gh release edit v20230929.11 --latest
```

## Repo

```powershell
gh repo list solidify-internal -L 200
```
