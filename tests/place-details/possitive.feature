Feature: Get Place Details

Background:
    * url url

Scenario Outline: placeDetails with required parameters only
    # Find place from text
    Given path 'findplacefromtext/json'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param key = apiKey
    When method GET
    Then status 200
    * def placeId = response.candidates[0].place_id

   # Place details
    Given path 'details/json'
    And param place_id = placeId
    And param key = apiKey
    When method GET
    Then status 200
    * match response.status == 'OK'
    # @Todo: verify all attributes in response

    Examples:
      | input        | inputtype   |
      | Vietnam      | textquery   |
      | +84987887666 | phonenumber |

  Scenario Outline: placeDetails with required and optional parameters as <Scenario>
    # Find place from text
    Given path 'findplacefromtext/json'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param key = apiKey
    When method GET
    Then status 200
    * def placeId = response.candidates[0].place_id

    # Place details
    Given path 'details/json'
    And param place_id = placeId

    And param fields = <fields>
    And param language = <language>
    And param region = <region>
    And param reviews_no_translations  = <reviews_no_translations>
    And param reviews_sort  = <reviews_sort>
    And param sessiontoken  = <sessiontoken>

    And param key = apiKey
    When method GET
    Then status 200
    * match response.status == 'OK'
    # @Todo Need Verify the output of this each parameters to check the responses
    # Verify the response displayed includes fields and following the declared parameters: language, region, reviews_no_translations,reviews_sort
    Examples:
      | Scenario                           | input   | inputtype | fields                                                              | language | region | reviews_no_translations | reviews_sort  | sessiontoken                          |
      | fields include Basic category      | Sai Gon | textquery | 'place_id,formatted_address,geometry'                               | ja       | 'uk'   | true                    | newest        | 'b2d6c707-43a5-4eeb-aae1-75ae590dbf83 |
      | fields include Contact category    | Vincom  | textquery | 'place_id,formatted_address,geometry,opening_hours/open_now'        | vi       | 'cn'   | false                   | most_relevant | '12345'                               |
      | fields include Atmosphere category | Big C   | textquery | 'place_id,formatted_address,geometry,opening_hours/open_now,rating' | en       | 'vn'   | true                    | newest        | 'abcdef'                              |
