% Azure DevOps Administration

# Upgrade procedure

## Check requirements

- Windows version
- Sql Server version
- RAM
- Disk space (installation, databses and backups)

Use **tfs-apptier** to check the AzDo admin (https, virual IIS path, ports and how big the databases are). Check and see if we should recommend any changes.

## Accuont permissions

- Administrator for Azure DevOps,
- Member of the SQL Server System Administrators group
- (if your deployment uses SharePoint Products) a member of the Farm Administrators group

## Upgrade procedure

- Order a snapshot (maintainance)
- Back up the databases (in AzDo Server Admin Console, Tfs_DefaultCollection, Tfs_Configuration)
- In-place upgrade (Download .exe and run)
- Update all agents, from the agent pools in AzDo

## Verification steps

-> Users, license management
-> Chack that some board works (Add/remove/link cards)
-> Run some build/deployment pipelines
-> Clone a git repo

# Project migration

## Repos

Use API or Import

## Work items

https://nkdagility.github.io/azure-devops-migration-tools/getting-started

Run from a VM in Azure Portal, Windows Server 2019, 32 GB RAM
