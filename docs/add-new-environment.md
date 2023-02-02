# Adding a new Environment

Lets say you want to add an environment named "proof of concept" (or `poc` for short).  Here's what you need to change:

* [env](../env/) - Add a file named `poc.parameters.json`. Optionally copy the structure from another one (but make sure you change the config to be appropriate!  In particular the `environment` variable)
* [main.bicep](../main.bicep) - Update `@allowed` to include `poc`
* [azure-pipelines.deploy.yml](../azure-pipelines.deploy.yml) - Allowed values for `environment` parameter

Also, you should check if any of the following environment-based conditions are relevant to your new environment:

* [main.bicep](../main.bicep): `lock_data_resources`
* [azure-pipelines.deploy.yml](../azure-pipelines.deploy.yml): condition on `tag_deployment`
