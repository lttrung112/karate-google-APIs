Feature: findplacefromtext

Background:
    * url url

Scenario: even number 2

#    Given path 'findplacefromtext/json?input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=' + apiKey
    Given path 'findplacefromtext/json'
#    And param input = 'Museum%20of%20Contemporary%20Art%20Australia'
    And param input = 'Museum of Contemporary Art Australia'
    And param inputtype = 'textquery'
    And param fields = 'formatted_address,name,geometry'
    And param key = apiKey
    When method GET
    Then status 200

