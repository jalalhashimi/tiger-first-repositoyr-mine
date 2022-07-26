Feature: Create an account and add address to the account.

  # Step 1) Get a token
  # Step 2) Generate ana ccount
  # Step3) Add address to the generated account
  Background: Create new account.
    Given url "https://tek-insurance-api.azurewebsites.net/"
    * def createAccountResult = callonce read('CreateAccountFeature.feature')
    And print createAccountResult
    * def primaryPersonId = createAccountResult.response.id
    * def newToken = createAccountResult.getToken.response.token

  Scenario: Add address to an account
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = primaryPersonId
    Given header Authorization = "Bearer " + newToken
    Given request
      """
      {
      "addressType": "Home",
      "addressLine1": "123 Somewhere Street",
      "city": "Nice City",
      "state": "VA",
      "postalCode": "23222",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
