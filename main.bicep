param location string = resourceGroup().location
param appServicePlanName string = ''
param webAppName string = ''
param dockerImage string = ''
param databaseServerName string = ''
@secure()
param databaseUser string = ''
@secure()
param databasePassword string = ''
param storageAccountName string = ''
param storageContainerNames array = []
@secure()
param jwtSecret string = ''
param jwtExpiration int = 3600
param jwtIssuer string = ''
param jwtAudience string = ''

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: 'B1'
    tier: 'Basic'
    capacity: 1
  }
}

// Web App with Docker
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOCKER|docker.io/${dockerImage}'
      healthCheckPath: '/api/health'
      appSettings: [
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://index.docker.io'
        }
        {
          name: 'POSTGRES_HOSTNAME'
          value: pgServer.properties.fullyQualifiedDomainName
        }
        {
          name: 'POSTGRES_USER'
          value: '${databaseUser}@${pgServer.properties.fullyQualifiedDomainName}'
        }
        {
          name: 'POSTGRES_PASSWORD'
          value: databasePassword
        }
        {
          name: 'POSTGRES_DATABASE'
          value: 'postgres'
        }
        {
          name: 'AZURE_STORAGE_ACCOUNT_NAME'
          value: storageAccount.name
        }
        {
          name: 'AZURE_STORAGE_ACCOUNT_KEY'
          value: storageAccount.listKeys().keys[0].value
        }
        {
          name: 'JWT_SECRET'
          value: jwtSecret
        }
        {
          name: 'JWT_EXPIRATION'
          value: string(jwtExpiration)
        }
        {
          name: 'JWT_ISSUER'
          value: jwtIssuer
        }
        {
          name: 'JWT_AUDIENCE'
          value: jwtAudience
        }
      ]
    }
  }
}

// PostgreSQL Server
resource pgServer 'Microsoft.DBforPostgreSQL/flexibleServers@2024-11-01-preview' = {
  name: databaseServerName
  location: location
  sku: {
    name: 'Standard_B4ms'
    tier: 'Burstable'
  }
  properties: {
    administratorLogin: databaseUser
    administratorLoginPassword: databasePassword
    version: '11'
    replica: {
      role: 'Primary'
    }
    storage: {
      iops: 120
      tier: 'P4'
      storageSizeGB: 32
      autoGrow: 'Disabled'
    }
    network: {
      publicNetworkAccess: 'Enabled'
    }
  }
}

resource allowAllWindowsAzureIps 'Microsoft.DBforPostgreSQL/flexibleServers/firewallRules@2024-11-01-preview' = {
  name: 'AllowAllWindowsAzureIps'
  parent: pgServer
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }
}

// Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2019-06-01' = {
  name: 'default'
  parent: storageAccount
}

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = [for name in storageContainerNames: {
  name: name
  parent: blobService
  properties: {
    publicAccess: 'Blob'
  }
}]

output webAppURL string = 'https://${webApp.properties.defaultHostName}'
output databaseServerURL string = pgServer.properties.fullyQualifiedDomainName
output storageURL string = storageAccount.properties.primaryEndpoints.blob
