param location string = resourceGroup().location
param appServicePlanName string = 'AdamDateAppServicePlan'
param webAppName string = 'adam-date'
param dockerImage string = 'adamayoung/adam-date-app:latest'
param pgServerName string = 'adam-date-postgres'
@secure()
param pgAdminUser string = 'adadmin' // Secure value should be passed at deployment time
@secure()
param pgAdminPassword string = 'Password123' // Secure value should be passed at deployment time
param storageAccountName string = 'adamdatestorage'
@secure()
param jwtSecret string = '00d3c9c0e7845d7a28cd9a03ff733f82537adfa12de8a65fd5af87be15c5368d906470d82e9239b7c05346b4ca43281f82a5f00f0bee69a22196b8928943c2c4b579bf8e36890cc174023825d1d153a5bbe7c66dd9f0db67912278594f2c87da635263bd84b01bb392a18de83f44497c0dd7dd6c22f888f1a23558f1a02a6797420793237146797203e827f3ad383e86a9e0367e5d55a6deef434af6907b96f7b338cbcfeb5cbf878d39b6aafaa878436b43b3b1773f1d819b302723355e15385348159343bf814ae38e9e8f98666bf565461859dc581918de09f2b36ee9e744211f175312164ff77117c8fb9a6eb6291c6b87cfb3d8e7370a8a1fdc12467399'
param jwtExpiration string = '3600'
param jwtIssuer string = 'AdamDate'
param jwtAudience string = 'AdamDate'

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
          name: 'POSTGRES_HOSTNAME'
          value: pgServer.properties.fullyQualifiedDomainName
        }
        {
          name: 'POSTGRES_USER'
          value: pgAdminUser
        }
        {
          name: 'POSTGRES_PASSWORD'
          value: pgAdminPassword
        }
        {
          name: 'POSTGRES_IDENTITY_DATABASE'
          value: 'postgres'
        }
        {
          name: 'POSTGRES_PROFILE_DATABASE'
          value: 'postgres'
        }
        {
          name: 'POSTGRES_REFERENCE_DATA_DATABASE'
          value: 'postgres'
        }
        {
          name: 'POSTGRES_PORT'
          value: '5432'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: 'https://index.docker.io'
        }
        {
            name: 'JWT_SECRET'
            value: jwtSecret
        }
        {
            name: 'JWT_EXPIRATION'
            value: jwtExpiration
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
  name: pgServerName
  location: location
  properties: {
    administratorLogin: pgAdminUser
    administratorLoginPassword: pgAdminPassword
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

// Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
