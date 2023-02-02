# Template - Bicep

This repository contains an opinionated template for using Azure Bicep for IaC and includes CI definitions for Azure DevOps.  Other things of note:

* Can handle multiple environments with different configuration (comes with `dev`, `uat`, `preprod` and `prod` out of the box)
* Azure DevOps pipelines should just work (some AzDo setup required, see [extra docs](docs/azure-devops.md))
* Some useful scripts (currently just one)

## Zero to Hero

Make sure you've got the following installed:

* Git
* [Visual Studio Code](https://code.visualstudio.com/)
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* Bicep - install via the Azure CLI
  * This repo is known to work with Bicep v0.9.1 and you can install this version by running `az bicep install --version v0.9.1`.  Later versions will probably work fine but, as things are changing rapidly in Bicep land, it's not guaranteed!

When you open the repo in VSCode, make sure you install all the recommended extensions!

## Assumptions

As noted above, this is an opinionated setup!  Here are some things to bear in mind:

* All Bicep linting issues are marked as errors
* You should define your actual resources in modules - see the [network module](modules/network.bicep) as an example.
* The `shared_vars` object should contain everything that might be needed by mutliple modules
* Module outputs should be named identically to the module itself.  Taking the network module as an example, variables would be available under `network.outputs.network` (this is a bit unwieldly but ultimately tidier IMO)
* All Bicep deployments should be done by CI (configuration for AzDo is included). If you really need to run locally, have a look at the [deployment file](build/deploy.yml) to see what to do.

## Resources

Working out the name for the Azure Resource you want is non trivial; the names are tenuous at best!  Luckily they're all written down in their reference documentation [here](https://docs.microsoft.com/en-us/azure/templates/).  Even with this it isn't super obvious, but it _will_ confirm what parameters are available.  This also includes links to examples - these can be really helpful to see an example that _should_ work.

The Azure DevOps YAML reference is [here](https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/?view=azure-pipelines).

## Other Docs

* [Using Azure Devops](./docs/azure-devops.md)
* [Adding an environment](./docs/add-new-environment.md)

## Contributing

Contributions are very welcome!  Some things I want to add include:

* Example configurations for other CI tools
* Updating the Bicep version as we go and ensuring (for example) the `bicepconfig.json` file contains all settings

## License

MIT
