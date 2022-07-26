# 2)Test API endpoint "/api/accounts/add-primary-account" to add new Account with Existing email address.
# Then status code should be 400 – Bad Request ,  validate response
Feature: Add new Account with Existing email address

  Background: generate token for all scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generateToken = response.token

  Scenario: Add new Account with Existing email address
    Given path "/api/accounts/add-primary-account"
    And request
      """
      {
      "email": "tiger29@gmail.com",
      "firstName": "Lee",
      "lastName": "John",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "Unemployed",
      "dateOfBirth": "1995-07-08",
      "new": true
      }
      """
    And header Authorization = "Bearer " + generateToken
    When method post
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Account with Email tiger29@gmail.com is exist"
    And print response
    Then status 400

  # 3)Test API endpoint "/api/accounts/add-account-car" to add car to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: Add car to an existing Account.
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = 42
    And request
      """
      {
      "make": "lamborghini",
      "model": "Avandor",
      "year": "2022",
      "licensePlate": "VIP-2022"
      }
      """
    * def generatedToken = response.token
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then print response
    And assert response.model == "Avandor"
    Then status 201

  #* def expectedOutput = read('result.json')
  #And match response == expectedOutput
  #* def validate = response.status
  # 4)Test API endpoint "/api/accounts/add-account-phone" to add Phone number to existing account.
  # Then status code should be 201 – Create ,  validate response
  Scenario: add Phone number to existing account.
    * def expected = read('add-accout-phone.json')
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = 42
    And request
      """
      {
      "id": 0,
      "phoneNumber": "0780000037",
      "phoneExtension": "100",
      "phoneTime": "Morning",
      "phoneType": "Home"
      }
      """
    * def generatedToken = response.token
    And header Authorization = "Bearer " + generatedToken
    When method post
    And print response
    And match response == expected
    Then status 201

  # 5)Test API endpoint "/api/accounts/add-account-address" to add address to existing account.
  # Then status code should be 201 – Create ,  validate response
  #* def expectedAddress = read('add-account-address.json')
  #And match response == expectedAddress
  Scenario: add address to existing account.
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = 42
    And request
      """
       {
      "addressType": "Home",
      "addressLine1": "123 Beautiful Ave",
      "city": "Nice City",
      "state": "Virginia",
      "postalCode": "23333",
      "current": true
      }
      """
    And def generateToken = response.token
    And header Authorization = "Bearer " + generateToken
    When method post
    And print response
    * def expectedText = response.state
    And assert expectedText == "Virginia"
    Then status 201
