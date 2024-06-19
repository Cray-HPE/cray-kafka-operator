# cray-kafka-operator

### Description
cray-kafka-operator is an extension of the official strimzi kafka-operator helm chart for use in CSM environment. 
Deploying this helm chart adds the strimzi cluster operator in operators namespace and adds the Strimzi kafka CRDs.
There is another repository that works in tandem with this for creating the custom resources needed for Kafka setup - [cray-shared-kafka](#https://github.com/Cray-HPE/cray-shared-kafka) 

### Prerequisites
1. As part of upgrading to a new version, make sure the latest version images are added to artifactory. 
This can be done as part of [container-images](#https://github.com/Cray-HPE/container-images)
2. Helm does not support upgrading CRDs during chart upgrade. They need to be upgraded explicitly which is handled as part of the templates.
Make sure to update the latest CRDs in [files directory](/kubernetes/cray-kafka-operator/files)
The latest CRDs can be fetched from [upstream strimzi release deliverables](https://github.com/strimzi/strimzi-kafka-operator/releases/tag/) 

### Installation
Once the changes are done, the helm charts are added to artifactory in unstable directory if commits are made to the development branch (or) in stable directory once the changes are merged to master branch.
These charts can be deployed on a cluster using standard helm commands - 
```text
helm upgrade --install <release-name> <chart> -n <namespace>
```
As an example,
```text
helm upgrade --install cray-kafka-operator cray-kafka-operator-1.1.0.tgz -n operators 
```

### Contributing
See the [CONTRIBUTING.md](/CONTRIBUTING.md) file for how to contribute to this project.

### License
This project is copyrighted by Hewlett Packard Enterprise Development LP and is distributed under the MIT license. See the [LICENSE](/LICENSE) file for details.
