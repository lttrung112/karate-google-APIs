Feature: findplacefromtext

Background:
    * url url

Scenario: findplacefromtext with missing input parameters
    Given path 'findplacefromtext/json'
    And param inputtype = 'textquery'
    And param key = apiKey
    When method GET
    Then status 200
    * match response.status == 'OK'
    * match response.candidates[0].place_id == '#string'

Scenario: findplacefromtext with missing inputtype parameters
    Given path 'findplacefromtext/json'
    And param input = 'test'
    And param key = apiKey
    When method GET
    Then status 200
    * match response.status == 'OK'
    * match response.candidates[0].place_id == '#string'


    Scenario: findplacefromtext with missing parameters
        Given path 'findplacefromtext/json'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'OK'
        * match response.candidates[0].place_id == '#string'

    Scenario: findplacefromtext with missing key parameters
        Given path 'findplacefromtext/json'
        And param input = 'test'
        And param inputtype = 'textquery'
        When method GET
        Then status 200
        * match response.status == 'OK'
        * match response.candidates[0].place_id == '#string'

    Scenario: findplacefromtext with invalid key
        Given path 'findplacefromtext/json'
        And param input = 'test'
        And param inputtype = 'textquery'
        When method GET
        Then status 200
        * match response.status == 'OK'
        * match response.candidates[0].place_id == '#string'