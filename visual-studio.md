# Visual Studio
<!--ts-->
<!--te-->

## Troubleshooting

### DLL missing

Do a windows search in the packages directory of the project, after the missing dll.
If found, paste it manually in the bin/Debug or bin/Release folder. Try to build again.
If successful, this means that Visual Studio is not configured to copy the dll files upon building.
