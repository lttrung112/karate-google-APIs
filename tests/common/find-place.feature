Feature: Common function to findplacefromtext

Background:
    * url url

Scenario Outline: findplacefromtext with required parameters only and existing result
    Given path 'findplacefromtext/json'
    And param input = '<input>'
    And param inputtype = '<inputtype>'
    And param key = apiKey
    When method GET
    Then status 200
    * def placeId = response.candidates[0].place_id

    Examples:
      | input   | inputtype |
      | Vietnam | textquery |
