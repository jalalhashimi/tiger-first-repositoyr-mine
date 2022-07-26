Feature: Create account with Data generator
  # We are going to re-use a generate token feature.
  Background: Prepare for test. generate token.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
  
    Scenario: Create New Account using Data generator; 
        * def generator = Java.type('tiger.api.test.data.DataGenerator')
        * def email = generator.getEmail()
        * def firstName = generator.getFirstName()
        * def lastName = generator.getLastName()
        * def dob = generator.getDob()
        Given path "/api/accounts/add-primary-account"
    And request
    """ 
    {
    "email": "#(email)",
    "title": "Mr.",
    "firstName": "#(firstName)",
    "lastName": "#(lastName)",
    "gender": "MALE",
    "maritalStatus": "MARRIED",
    "employmentStatus": "student",
    "dateOfBirth": "#(dob)"
    }
    """
    * def generatedToken = response.token
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    * def generatedId = response.id
    And print generatedId
    And print response
    Then assert response.email == email