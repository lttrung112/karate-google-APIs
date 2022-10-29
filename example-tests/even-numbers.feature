Feature: fetching even numbers

Background:
    * url url

Scenario: even number 2

    Given path 'findplacefromtext/json?input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=' + apiKey
    When method GET
    Then status 200
#    And match $.iseven == true

#Scenario: even number 4
#
#    Given path '/api/iseven/4'
#    When method GET
#    Then status 200
#    And match $.iseven == true