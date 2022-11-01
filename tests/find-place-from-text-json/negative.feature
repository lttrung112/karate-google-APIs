Feature: findplacefromtext

Background:
    * url url

    Scenario: findplacefromtext with missing 'input' parameters
        Given path 'findplacefromtext/json'
        And param inputtype = 'textquery'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.candidates == '#[0]'

    Scenario: findplacefromtext with missing 'inputtype' parameters
        Given path 'findplacefromtext/json'
        And param input = 'test'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.candidates == '#[0]'


    Scenario: findplacefromtext with missing all required parameters
        Given path 'findplacefromtext/json'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.candidates == '#[0]'

    Scenario: findplacefromtext with missing 'key' parameters
        Given path 'findplacefromtext/json'
        And param input = 'test'
        And param inputtype = 'textquery'
        When method GET
        Then status 200
        * match response.status == 'REQUEST_DENIED'
        * match response.error_message == 'You must use an API key to authenticate each request to Google Maps Platform APIs. For additional information, please refer to http://g.co/dev/maps-no-account'
        * match response.candidates == '#[0]'

    Scenario: findplacefromtext with invalid 'key'
        Given path 'findplacefromtext/json'
        And param input = 'test'
        And param inputtype = 'textquery'
        And param key = '123456'
        When method GET
        Then status 200
        * match response.status == 'REQUEST_DENIED'
        * match response.error_message == 'The provided API key is invalid.'
        * match response.candidates == '#[0]'

    Scenario: findplacefromtext with invalid 'phonenumber' format
        Given path 'findplacefromtext/json'
        And param input = '123456'
        And param inputtype = 'phonenumber'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.candidates == '#[0]'


    Scenario: findplacefromtext with invalid 'inputtype'
        Given path 'findplacefromtext/json'
        And param input = '123456'
        And param inputtype = 'abc'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.candidates == '#[0]'

    Scenario: findplacefromtext with invalid 'locationbias' format
        Given path 'findplacefromtext/json'
        And param input = '123456'
        And param inputtype = 'abc'
        And param key = apiKey
        And param locationbias = '123'
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.candidates == '#[0]'

    Scenario: findplacefromtext with invalid 'fields' format
        Given path 'findplacefromtext/json'
        And param input = '123456'
        And param inputtype = 'textquery'
        And param fields = 'place_id.formatted_address,geometry'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.error_message == 'Error while parsing 'fields' parameter: Unexpected character '.'. '
        * match response.candidates == '#[0]'

    Scenario: findplacefromtext with invalid 'fields' value
        Given path 'findplacefromtext/json'
        And param input = '123456'
        And param inputtype = 'textquery'
        And param fields = 'curbside_pickup,formatted_address,geometry'
        And param key = apiKey
        When method GET
        Then status 200
        * def errorResponse =
        """
        {
           "candidates" : [],
           "error_message" : "Error while parsing 'fields' parameter: Unsupported field name 'curbside_pickup'. ",
           "status" : "INVALID_REQUEST"
        }
        """
        * match response == errorResponse

    # @Todo: Question: could you please provide data for these cases to response as below?:
    #    Scenario: findplacefromtext incase response as "OVER_QUERY_LIMIT"
    #    Scenario: findplacefromtext incase response as "UNKNOWN_ERROR "