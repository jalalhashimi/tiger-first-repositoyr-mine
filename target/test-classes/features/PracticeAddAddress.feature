@Regression
Feature: Add an address to the new created account

Background: create new account
Given url "https://tek-insurance-api.azurewebsites.net/"
* def getAccountConnection = callonce read('CreateAccountFeature.feature')
And print getAccountConnection
* def dynamicId = getAccountConnection.response.id
* def getNewToken = getAccountConnection.getToken.response.token

Scenario: Add a new address to the generated account
Given path "/api/accounts/add-account-address"
And param primaryPersonId = dynamicId
And header Authorization = "Bearer " + getNewToken
And request
"""
{
  "addressType": "Home",
  "addressLine1": "555 Nice Street",
  "city": "Nice City",
  "state": "Virginia",
  "postalCode": "21111",
    "current": true
}
"""
When method post
Then status 201
Then print response
