Feature: Find place from text

Background:
    * url url

Scenario Outline: findplacefromtext with required parameters only and existing result
    Given path 'findplacefromtext/json'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param key = apiKey
    When method GET
    Then status 200
    * match response.status == 'OK'
    * match response.candidates[0].place_id == '#string'

    Examples:
      | input        | inputtype   |
      | Ha Noi       | textquery   |
      | abc          | textquery   |
      | 123          | textquery   |
      | true         | textquery   |
      | null         | textquery   |
      | undefined    | textquery   |
      | +84987887666 | phonenumber |

  Scenario Outline: findplacefromtext with required parameters only and existing result as a list
    Given path 'findplacefromtext/json'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param key = apiKey
    When method GET
    Then status 200
    * assert response.candidates.length > 1
    * match response.status == 'OK'

    Examples:
      | input         | inputtype   |
#      |District      | textquery|  |
      | +842838200880 | phonenumber |

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
      | input        | inputtype   |
      | 012aaa       | textquery   |
      | +84123456789 | phonenumber |

  Scenario Outline: findplacefromtext with required and optional parameters as <Scenario>
    Given path 'findplacefromtext/json'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param fields = <fields>
    And param language = '<language>'
    And param locationbias = <locationbias>
    And param key = apiKey
    When method GET
    Then status 200
    # @Todo Need Verify the output of this each parameters to check the responses
    # Verify the response displayed includes fields and following the declared language

    Examples:
      | Scenario                           | input   | inputtype | fields                                                              | language | locationbias                                |
      | fields include Basic category      | Sai Gon | textquery | 'place_id,formatted_address,geometry'                               | ja       | 'circle%3A2000%4047.6918452%2C-122.2226413' |
      | fields include Contact category    | Vincom  | textquery | 'place_id,formatted_address,geometry,opening_hours/open_now'        | vi       | 'circle%3A2000%4047.6918452%2C-122.2226413' |
      | fields include Atmosphere category | Big C   | textquery | 'place_id,formatted_address,geometry,opening_hours/open_now,rating' | en       | 'circle%3A2000%4047.6918452%2C-122.2226413' |
