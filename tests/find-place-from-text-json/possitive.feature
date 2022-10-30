Feature: findplacefromtext

Background:
    * url url

Scenario Outline: findplacefromtext with required parameters only and existing result

#    Given path 'findplacefromtext/json?input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry&key=' + apiKey
    Given path 'findplacefromtext/json'
#    And param input = 'Museum%20of%20Contemporary%20Art%20Australia'
#    And param input = 'Museum of Contemporary Art Australia'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param key = apiKey
    When method GET
    Then status 200
    * match response.status == 'OK'
    * match response.candidates[0].place_id == '#string'

    Examples:
    |input        | inputtype|
    |Ha Noi       | textquery|
    |abc          | textquery|
    |123          | textquery|
    |true         | textquery|
    |null         | textquery|
    |undefined    | textquery|
    |Name@country | textquery|
    |+84987887666 | phonenumber|

  Scenario Outline: findplacefromtext with required parameters only and existing list of result
    Given path 'findplacefromtext/json'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param key = apiKey
    When method GET
    Then status 200
    * print "111111", response.candidates.length
    Then assert response.candidates.length > '1'
    * match response.status == 'OK'

    Examples:
      |input         | inputtype|
      |district      | textquery|
      |+842838200880 | phonenumber|

  Scenario Outline: findplacefromtext with required parameters only and not existing result
    Given path 'findplacefromtext/json'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param key = apiKey
    When method GET
    Then status 200
    * match response.status == 'ZERO_RESULTS'
#    * match response.candidates.length == '#notpresent'
    * match response.candidates == '#[0]'

    Examples:
      |input        | inputtype|
      |012aaa       | textquery|
      |+84123456789 | phonenumber|

#curl -L -X GET 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Ha+noi&inputtype=textquery&key=AIzaSyCDcUmm1LO0yeRVqdPsxo2ku6-weisiWHk'

#curl -L -X GET 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Name@country&inputtype=textquery&key=AIzaSyCDcUmm1LO0yeRVqdPsxo2ku6-weisiWHk'
  Scenario Outline: findplacefromtext with required parameters and optional parameters

        Given path 'findplacefromtext/json'
        And param input = '<input>'
        And param inputtype = 'textquery'
        And param fields = 'formatted_address,name,geometry'
        And param key = apiKey
        When method GET
        Then status 200

        Examples:
            |input  |
            |Ha Noi |
            |abc    |
            |123    |
