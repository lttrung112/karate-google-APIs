Feature: findplacefromtext

Background:
    * url url

    Scenario: findplacefromtext with missing input parameters
    Given path 'findplacefromtext/json'
    And param inputtype = 'textquery'
    And param key = apiKey
    When method GET
    Then status 200
    * match response.status == 'INVALID_REQUEST'
    * match response.candidates == '#[0]'

    Scenario: findplacefromtext with missing inputtype parameters
    Given path 'findplacefromtext/json'
    And param input = 'test'
    And param key = apiKey
    When method GET
    Then status 200
    * match response.status == 'INVALID_REQUEST'
    * match response.candidates == '#[0]'


    Scenario: findplacefromtext with missing required parameters
        Given path 'findplacefromtext/json'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.candidates == '#[0]'

    Scenario: findplacefromtext with missing key parameters
        Given path 'findplacefromtext/json'
        And param input = 'test'
        And param inputtype = 'textquery'
        When method GET
        Then status 200
        * match response.status == 'REQUEST_DENIED'
        * match response.error_message == 'You must use an API key to authenticate each request to Google Maps Platform APIs. For additional information, please refer to http://g.co/dev/maps-no-account'
        * match response.candidates == '#[0]'

    Scenario: findplacefromtext with invalid key
        Given path 'findplacefromtext/json'
        And param input = 'test'
        And param inputtype = 'textquery'
        And param key = '123456'
        When method GET
        Then status 200
        * match response.status == 'REQUEST_DENIED'
        * match response.error_message == 'The provided API key is invalid.'
        * match response.candidates == '#[0]'