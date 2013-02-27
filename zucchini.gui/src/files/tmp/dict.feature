 Feature: check extended dictionary
   Scenario: show dictionary
     Given I load lesson "carolina/utopia" page "1"
     And I press "btn_dictionary"
     And I press "addKeyword"
     And I should see "NOWY" in additional dictionary keyword
     And I should see "OPIS" in additional dictionary description


   