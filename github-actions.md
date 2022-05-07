# GitHub Actions

## Workflow

### Fail, throw error

#### github-script, with error message

```yml
- name: A/B Check
  if: ${{ envA }} != ${{ envB }}
  uses: actions/github-script@v3
  with:
    script: |
        core.setFailed('envA and envB are not equivalent!')
```

#### exit()

```yml
- name: Try to fail
  if: ${{ envA }} != ${{ envB }}
  run: exit 1
```

## Custom Actions

