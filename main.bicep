// Parameters
// These come from env/*.parameters.json
@allowed(['dev', 'uat', 'preprod', 'prod'])
param environment string = 'dev'
param network_settings object

// Overwritten when deploying via Azure Pipelines
param deployment_id string = '0'

// If you want to manage multiple resource groups, you can change this to `subscription`
targetScope = 'resourceGroup'

// Variables
var shared_vars = {
  module_prefix: '${environment}-${deployment_id}'
  resource_prefix: '${environment}-cust'
  resource_prefix_nohyphen: '${toLower(environment)}cust'
  location: 'uksouth'
  lock_data_resources: bool(environment != 'dev')
  base_tags: {
    customer: 'cust'
    application: 'app'
    environment: environment
  }
}

// An example module, though you will most likely need a VNet!
module network 'modules/network.bicep' = {
  name: '${shared_vars.module_prefix}-network'
  params: {
    shared_vars: shared_vars
    network_settings: network_settings
  }
}

// Output variables available via `network.output.network`
