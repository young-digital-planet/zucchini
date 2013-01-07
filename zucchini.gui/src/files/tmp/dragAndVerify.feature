Feature: checkbox working
   Scenario: check checkbox button
     Given I load lesson "lesson_sourcelista/utopia_1" page "1"
     And I drag "#1" to "#1"
     And I should see "tlenek wapnia" in the "#1" element