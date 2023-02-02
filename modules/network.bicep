// Place params at the top to make clear what the inputs are
param shared_vars object
param network_settings object

// Module-specific variables
var tags = union(shared_vars.base_tags, { module: 'network'})

// Azure resources
resource nsg 'Microsoft.Network/networkSecurityGroups@2021-08-01' = {
  name: '${shared_vars.resource_prefix}-vnet-nsg'
  location: shared_vars.location
  tags: tags
  properties: {
    securityRules: [
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: '${shared_vars.resource_prefix}-vnet'
  location: shared_vars.location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        network_settings.vnet_cidr
      ]
    }
    subnets: [
      {
        name: '${shared_vars.resource_prefix}-vnet-subnet'
        properties: {
          addressPrefix: network_settings.subnet_cidr
          privateEndpointNetworkPolicies: 'Disabled'
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
    ]
  }
}

// Wrap outputs in an object to make referring to them a bit tidier down the line
output network object = {
  vnet_id: vnet.id
  subnet_id: resourceId('Microsoft.Network/VirtualNetworks/subnets', vnet.name, '${shared_vars.resource_prefix}-vnet-subnet')
}
