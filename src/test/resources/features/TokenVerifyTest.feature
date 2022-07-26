#1) Generate a vlide token and verify it with below requriement
# test api endpoint "/api/token/verify" with valid token.
# status should be 200 - bad request and response is true 
@regression
Feature: Security test. Verify Token test
	
Scenario: Verify valid token.
	Given url "https://tek-insurance-api.azurewebsites.net/"
	And path "/api/token"
	And request {"username": "supervisor", "password": "tek_supervisor"}
	When method post
	Then status 200
	* def generatedToken = response.token
	Given path "/api/token/verify"
	And param username = "supervisor" 
	And param token = generatedToken
	When method get
	Then status 200
	And print response
	
	#2) test api endpoint "/api/token/verify" with invalid token.
	# Note: since it's invalid token it can be any random string. you don't need to generate a new token
  # Status should be 400 – bad request and response should be TOKEN_EXPIRED
  # there is a defect open for this scenario already
  
  Scenario: Verify valid token.
	Given url "https://tek-insurance-api.azurewebsites.net/"
	And path "/api/token/verify"
	And param username = "supervisor" 
	And param token = "Wrong token"
	When method get
	Then status 400
	And print response
  
  
  
  
  
  