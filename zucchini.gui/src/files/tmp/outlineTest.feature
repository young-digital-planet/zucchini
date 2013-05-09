Feature: press button feature
   Scenario Outline: check button working
     Given I load lesson "lesson_zle_wyswietlanie/utopia_1" page "2"
     And I select <option>

     Examples:
     	| option |
     	| B. temperatura |
     	| C. dostępność wody |
     	| E. zawartość tlenu |