# Self Healing Architecture Exercises

This repo covers three lessons from the Udacity course "Site Reliability Engineer":

1. [lesson-1-system-design](./lesson-1-system-design/README.md)
2. [lesson-2-deployment-strategies](./lesson-2-deployment-strategies/README.md)
3. [lesson-3-cloud-automation](./lesson-3-cloud-automation/README.md)

The original repo is: [self-healing-architectures-exercises](https://github.com/udacity/nd087-c3-self-healing-architectures-exercises).

## Mandatory Kubernetes Setup
- [kubernetes](https://kubernetes.io/docs/tasks/tools/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) with activated Kubernetes
- [kubectl](https://kubernetes.io/docs/reference/kubectl/)
- [eksctl](https://eksctl.io/introduction/#installation)
- [awscli](https://aws.amazon.com/cli/)
- [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
- [helm](https://www.eksworkshop.com/beginner/060_helm/helm_intro/install/)
- [Hey Load testing](https://github.com/rakyll/hey)

## Kubernetes Helper Libraries
- [kubectx](https://github.com/ahmetb/kubectx#kubectx1)
- [kubens](https://github.com/ahmetb/kubectx#kubens1)

## AWS CLI Setup with multiple profiles 
Based on [Set Up the AWS CLI](https://aws.amazon.com/de/getting-started/guides/setup-environment/module-three/)
proceed as follows:

1. Install the AWS CLI and verify with: `aws --version`
2. Create new profile with `aws configure --profile <profile_name>` and set:
    1. AWS Access Key ID
    2. AWS Secret Access Key
    3. Default Region (e.g. us-east-1)
    4. Default Output Format (i.e. json)
3. Get the available profiles with `aws configure list-profiles`
4. Switch the profile depending on your OS with:
    1. Linux and MacOS -> `export AWS_PROFILE=admin`
    2. Windows Command Prompt -> `setx AWS_PROFILE admin`
    3. PowerShell -> `$Env:AWS_PROFILE="admin"`
5. Get the currently used profile with `aws configure list`
6. Verify the currently active profile with `aws sts get-caller-identity`
7. Exemplary list S3 buckets from this profile with: `aws s3 ls --profile <profile_name>`
8. Remove unwanted profiles (or add manually), by editing the config files:
    1. `vi ~/.aws/credentials`
    2. `vi ~/.aws/config`
9. Check the successful configuration of the AWS CLI, by running either of the following AWS command:
```
# If you've just one profile set locally
aws iam list-users

# If you've multiple profiles set locally
aws iam list-users --profile <profile-name>
```

**Important**
If you have already set the temporary AWS Access keys generated in the classroom that expires after the session ends, you should set the aws_session_token to a blank string, using the command below:
```
# Configure a single field
aws configure set aws_session_token "" --profile default
```
Otherwise, you may encounter InvalidClientTokenId error while running AWS CLI commands.

# Visualizing AWS EKS Cluster
You may visualize your AWS EKS cluster in exercise 3 using the helm chart `kube-ops-view`

1. Install [helm](https://www.eksworkshop.com/beginner/060_helm/helm_intro/install/)
2. Add the stable repo: `helm repo add stable https://charts.helm.sh/stable`
3. Install the helm chart `kube-ops-view`
    ```
    helm install kube-ops-view \
    ```
   or
    ``` 
    helm stable/kube-ops-view \
    ```
   with
    ```
    --set service.type=LoadBalancer \
    --set rbac.create=True
    ```
4. Confirm the helm chart is installed successfully
    - `helm list`

5. Get the service url to view the cluster dashboard
- `kubectl get svc kube-ops-view | tail -n 1 | awk '{ print "Kube-ops-view URL = http://"$4 }'`

To remove this deployment use: `helm uninstall kube-ops-view`

## Visualizing Local Kubernetes Cluster
You may visualize your local kubernetes cluster using the `ops-view` deployment found in the [visual-support](https://github.com/udacity/nd087-c3-self-healing-architectures-exercises/tree/7ff0779bfbc514ca11334bd3912d8d6060e50533/lesson-2-deployment-strategies/exercises/starter/visual-support) directory
1. `kubectl apply -f visual-support/ops-view.yml`
2. Visit the URL `http://localhost:30092/` on your browser

Remove this deployment using: `kubectl delete -f visual-support/ops-view.yml`
