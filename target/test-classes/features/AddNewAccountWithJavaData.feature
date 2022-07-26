Feature: Add new Account

  Background: Generate token and open the page
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenFile = callonce read("GenerateToken.feature")
    And print tokenFile
    * def resultOfToken = tokenFile.response.token
    And print resultOfToken
    Then header Authorization = "Bearer " + resultOfToken

  Scenario: Create a new account with Auto generated data
    Given path "/api/accounts/add-primary-account"
    * def myData = Java.type('tiger.api.test.data.FakeData')
    * def email = myData.getEmail()
    * def name = myData.getFirstName()
    * def lastName = myData.getLastName()
    * def dateOfBirth = myData.getDOB()
    And request
      """
      {
      "id": 0,
      "email": "#(email)",
      "firstName": "#(name)",
      "lastName": "#(lastName)",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "#(dateOfBirth)",
      "new": true
      }
      """
    And method post
    And status 201
    * def createNewID = response.id
    Then print createNewID
    And print response
    Then assert response.email == email
