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

Do the upgrade as a service user

- Order a snapshot (maintainance)
  - For an in-place upgrade, it's sufficient to just back up the databases (in AzDo Server Admin Console, Tfs_DefaultCollection, Tfs_Configuration).
- Take a screenshot of the configuration in the AzDo Admin console
- Download the .iso from https://docs.microsoft.com/en-us/azure/devops/server/download/azuredevopsserver?view=azure-devops and run)
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

### Checklist
- Cerate the target project
- On the target project, ensure that on the Process, all work item types have the ReflectWorkItemId hidden property.
- Download the tool and init the configuration file
- Source and Target: Set projects and AuthenticationMode (Prompt, AccessToken)
- Set LogLevel=Debug, Enabled=true, FixHtmlAttachmentLinks=true, clear NodeBasePaths 
