# SonarQube

<!--ts-->
* [SonarQube](sonarqube.md#sonarqube)
   * [Troubleshooting](sonarqube.md#troubleshooting)
      * [SonarQube, buildwrapper. SonarQube scan does not produce any scan results when running locally.](sonarqube.md#sonarqube-buildwrapper-sonarqube-scan-does-not-produce-any-scan-results-when-running-locally)

<!-- Added by: runner, at: Tue Feb  1 12:47:12 UTC 2022 -->

<!--te-->

## Troubleshooting

### SonarQube, buildwrapper. SonarQube scan does not produce any scan results when running locally.

Make sure to:
- use the correct SQ buildwrapper, e.g. C++, .NET, etc.
- The script invoking the build wrapper and executing the scan runs inside the project folder.
