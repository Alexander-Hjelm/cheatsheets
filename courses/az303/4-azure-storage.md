# Azure ARM Templates

## Storage types

- VM Storage
  - Disks
  - Files (managed file shares in the cloud)
- Unstructured data
  - Azure Blob Storage (rest based object storage)
  - Azure Datalake Storage
Structured data
  - Azure Table Storage (key-value noSQL)
  - Azure Cosmos DB
  - Azure SQL DB (SQL database service)

## Storage types (Detailed)

### Azure Blobs

Massively scalable

- Object storage (Text, images, binary data)
- Streaming video/data
- Ideal for storing backups
- Great solution for storing data for analysis
- Access via http/https
  - Urls or Rest api

Hot/Cool/Archive storage tiers.

### Azure Files

Fileshare service. Managed for you, rather than having to manage it inside a VM.

Ideal for
- Config files
- Diagnostic files

### Azure Queues

Queue storage.
Pass messages/data from one application to another via a queue.

### Azure Tables

Key-value-pair structured data (noSQL)

Quickstart templates: https://github.com/Azure/azure-quickstart-templates

## Security

Each storage type can be protected with:
- RBAC access control
- Access keys (public/private)
- Limit access to certain virtual networks.
- Force SSL
- Always encrypted at rest by default.

### Has
-

## ARM Templates walkthrough

### Via portal

1.  

### Via CLI

1.

2.07.25