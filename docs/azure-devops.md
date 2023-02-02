# Azure Devops

This repo contains everything you need to use Azure DevOps for CI and deployment.  There are however some things you need to do \ be aware of.

## Pipelines

There are two configured AzDo pipelines:

* [CI](../azure-pipelines.ci.yml)
  * Builds the Bicep code (which includes linting the code) and stores the resulting ARM template as an artifact
  * If we're on the `main` branch, deploys to the `dev` environment
* [Deploy](../azure-pipelines.deploy.yml)
  * Builds the Bicep code (which includes linting the code) and stores the resulting ARM template as an artifact
  * Deploys to the given environment (passed in as a parameter)
  * If the environment is *not `dev`*, tags the commit with the environment and AzDo build number

## Setup

The pipelines use Service Principals of type `Azure Resource Manager`.  These need to be setup manually in AzDo by someone with enough project-level permissions.
In terms of naming, you have two choices:

* Name them after the environment names used in the repo (e.g. `dev`, `prod` etc.).  No repo changes are required
* Name them as you like.  You'll need to update all values of `azureSubscription` in the [build](../build/) directory accordingly.

## Service Principal permissions

By default, Service Principals get `Contributor` access to a given Resource Group.  If you want to setup access controls (e.g. Managed Identities), then this isn't enough (and the deployment will fail).  The best way to fix this is to edit the permissions available to the Service Principal via a custom RBAC role (Another way is to make it an `Owner` but that's a BAD idea!).

Fixing this is doable but a bit awkward.

### Service Principal Custom Role

You first need to define a custom role that includes the desired permissions.  An example role is in [this JSON file](AzureDevOps_Deployment.json) (which is essentially "Contributor + RBAC assignment").  BEfore importing this role, make sure you edit the value of `assignableScopes` to be your subscriptuion Id!

### Service Principal Setup

For each Service Principal:

* In AzDo, go to the Service Principal. Under Details, click on `Manage Service Principal`
* This will open up a page on the Azure Portal. Under Essentials, in the right column, click on the link to `Managed application in local directory` (will be truncated)
* Now go to the left pane -> Properties and change the name to something sensible (all Service Principals get the same name).  You should include the environment to make it clearer.  It may take a few minutes for the change to be reflected.  While this is optional, it's highly recommended so you can sensibly audit going forwards
* Finally, under the relevant resource group, go to IAM and add a role assignment for the (newly named) service principal and the custom role above.
