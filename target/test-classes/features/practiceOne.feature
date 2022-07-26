# update phone number for an existing account
# using "api/accounts/update-account-phone
Feature: update phone number

  Background: log in and generate token for all scenarios
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username":"supervisor","password":"tek_supervisor"}
    Then method post
    Then status 200
    * def newToken = response.token

  Scenario: update phone number for an existing account
    Given path "/api/accounts/update-account-phone"
    And param primaryPersonId = 1
    And request {"id": 1,"phoneNumber": "8042222222","phoneExtension": "222","phoneTime": "Morning","phoneType": "Home"}
    And header Authorization = "Bearer " + newToken
    And method put
    Then print response
    And status 200

  Scenario: update car for an existing account
    Given path "/api/accounts/update-account-car"
    And param primaryPersonId = 1
    And request {"id": 0,"primaryPerson": {"id": 0,"email": "tiger10@gmail.com","title": "Mr.","firstName": "John","lastName": "Ali","gender": "MALE","maritalStatus": "SINGLE","employmentStatus": "Student","dateOfBirth": "1970/01/01"},"make": "BMW","model": "M3","year": "2022","licensePlate": "BMW001"}
    * def tokenForCar = response.token
    And header Authorization = "Bearer " +  tokenForCar
    And method put
    And print response
    Then status 200

  #Scenario: update an existing account mailing address
    #Given path "/api/accounts/update-account-address"
    #And param primaryPersonId = 1
    #And request {"id": 1,"addressType": "Home","addressLine1": "123 Cute Ave","city": "Blossom City","state": "Virginia","postalCode": "23111","countryCode": "01"}
    #* def addressToken = respone.token
    #And header Authorization = "Bearer " + newToken
    #And method put
    #And print response
    #Then status 200
