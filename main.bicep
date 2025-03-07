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
resource pgServer 'Microsoft.DBforPostgreSQL/servers@2017-12-01' = {
  name: databaseServerName
  location: location
  properties: {
    administratorLogin: databaseUser
    administratorLoginPassword: databasePassword
    version: '11'
    sslEnforcement: 'Enabled'
    createMode: 'Default'
  }
  sku: {
    name: 'B_Gen5_1'
    tier: 'Basic'
    capacity: 1
  }
}

resource allowAllWindowsAzureIps 'Microsoft.DBforPostgreSQL/servers/firewallRules@2017-12-01' = {
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
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

output postgresHostname string = pgServer.properties.fullyQualifiedDomainName
