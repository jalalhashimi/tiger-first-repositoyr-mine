Feature: Create account with Data generator

  # We are going to re-use a generate token feature
  Background: prepare for test with generate token
     Given url "https://tek-insurance-api.azurewebsites.net"
     * def getToken = callonce read('GenerateToken.feature')
     And print getToken
     * def generatedToken = getToken.response.token
     And print generatedToken
     And header Authorization = "Bearer " + generatedToken
        #And path "/api/token"
    #And request {"username": "supervisor","password": "tek_supervisor"}
    #When method post
    #And status 200
    #* def generatedToken = response.token
    Scenario: Create New Account using Data generator.
    * def generator = Java.type('tiger.api.test.data.DataGenerator')
		* def email = generator.getEmail()
		* def firstName = generator.getFirstName()
		* def lastName = generator.getLastName()
		* def dob = generator.getDob()
		Given path "/api/accounts/add-primary-account/"
		And request
		"""
		{
  "email": "#(email)",
  "title": "Mr.",
  "firstName": "#(firstName)",
  "lastName": "#(lastName)",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Student",
  "dateOfBirth": "#(dob)",
	}
		"""
    When method post
    Then status 201
    * def generatedId = response.id
    And print generatedId
    And print response
    Then assert response.email == email
	