 Feature: fill text input
   Scenario: fill text in previous page
     Given I load lesson "56012_width_gap_in_chart/utopia_1" page "1"
	 And I fill in "#2" with "siemano"
 	 And I should see "siemano" in the "#2" element