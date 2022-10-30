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
      | input        | inputtype   |
      | Ha Noi       | textquery   |
      | abc          | textquery   |
      | 123          | textquery   |
      | true         | textquery   |
      | null         | textquery   |
      | undefined    | textquery   |
      | Name@country | textquery   |
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
#      |District      | textquery|
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

  Scenario Outline: findplacefromtext with required parameters and optional parameters as <Scenario>
    Given path 'findplacefromtext/json'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param fields = <fields>
    And param language = <fields>
    And param locationbias = <locationbias>
    And param key = apiKey
    When method GET
    Then status 200
    # @Todo Need Verify the output of this each parameters to check the responses

    Examples:
      | Scenario                           | input   | inputtype | fields                                                              | language | locationbias                      |
      | fields include Basic category      | Sai Gon | textquery | 'place_id,formatted_address,geometry'                               | ja       | circle:2000@41.761898,-72.674596  |
      | fields include Contact category    | Vincom  | textquery | 'place_id,formatted_address,geometry,opening_hours/open_now'        | vi       | circle:16000@41.761898,-72.674596 |
      | fields include Atmosphere category | Big C   | textquery | 'place_id,formatted_address,geometry,opening_hours/open_now,rating' | en       | circle:1@41.761898,-72.674596     |

