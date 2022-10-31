Feature: Get Place Details

Background:
    * url url
    # There is an error in call to another feature file so temporarily I don't use it.
    #    * def place = call read('classpath:tests/common/find-place.feature')
    * def placeId = 'ChIJXx5qc016FTERvmL-4smwO7A'

    Scenario: Get Place Details with missing 'place_id' parameters
        Given path 'details/json'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.error_message == 'Missing the placeid or reference parameter.'

    Scenario: Get Place Details with not existing 'place_id' parameters
        Given path 'details/json'
        And param place_id = "1234"
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'

    Scenario: Get Place Details with missing 'key' parameters
        Given path 'details/json'
        And param place_id = placeId
        When method GET
        Then status 200
        * match response.status == 'REQUEST_DENIED'
        * match response.error_message == 'You must use an API key to authenticate each request to Google Maps Platform APIs. For additional information, please refer to http://g.co/dev/maps-no-account'

    Scenario: Get Place Details  with invalid 'key'
        Given path 'details/json'
        And param place_id = placeId
        And param key = '123456'
        When method GET
        Then status 200
        * match response.status == 'REQUEST_DENIED'
        * match response.error_message == 'The provided API key is invalid.'

    Scenario: Get Place Details  with invalid 'region' format
        Given path 'details/json'
        And param place_id = placeId
        And param key = apiKey
        And param region = '123'
        When method GET
        Then status 200

    Scenario: Get Place Details  with invalid 'language' format
        Given path 'details/json'
        And param place_id = placeId
        And param key = apiKey
        And param language = '123'
        When method GET
        Then status 200

    Scenario: Get Place Details  with invalid 'reviews_no_translations' format
        Given path 'details/json'
        And param place_id = placeId
        And param key = apiKey
        And param reviews_no_translations = '123'
        When method GET
        Then status 200

    Scenario: Get Place Details  with invalid 'reviews_sort' format
        Given path 'details/json'
        And param place_id = placeId
        And param key = apiKey
        And param reviews_sort = '123'
        When method GET
        Then status 200

    Scenario: Get Place Details with invalid 'fields' format
        Given path 'details/json'
        And param place_id = placeId
        And param fields = 'place_id.formatted_address,geometry'
        And param key = apiKey
        When method GET
        Then status 200
        * match response.status == 'INVALID_REQUEST'
        * match response.error_message == "Error while parsing 'fields' parameter: Unexpected character '.'. "

    Scenario: Get Place Details with invalid 'fields' value
        Given path 'details/json'
        And param place_id = placeId
        And param fields = 'aaa,formatted_address,geometry'
        And param key = apiKey
        When method GET
        Then status 200
        * def errorResponse =
        """
        {
           "candidates" : [],
           "error_message" : "Error while parsing 'fields' parameter: Unsupported field name 'aaa'. ",
           "status" : "INVALID_REQUEST"
        }
        """
        * match response == errorResponse

    # @Todo: Question: could you please provide data for these cases to response as below?:
    #    Scenario: findplacefromtext incase response as "OVER_QUERY_LIMIT"
    #    Scenario: findplacefromtext incase response as "UNKNOWN_ERROR "