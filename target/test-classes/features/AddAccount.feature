Feature: Create Account

  #1) Test API endpoint "/api/account/add-primary-account" to add new Account (Same as we do fill the form in UI)
  # Then status code should be 201 - CREATED, with response generate account with Email address.
  Background: generate token for all scenarios.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generateToken = response.token

  Scenario: Create new Account happy path
    Given path "/api/accounts/add-primary-account"
    And request
      """
       {
      "id": 0,
      "email": "tiger25@gmail.com",
      "firstName": "Aaron",
      "lastName": "Robert",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "2000-02-02",
      "new": true
      }
      """
    And header Authorization = "Bearer " + generateToken
    When method post
    Then print response
    Then status 201
