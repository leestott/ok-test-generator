@javascript
Feature: add and delete tests

	Background:
		Given I am viewing "/"
	
	Scenario: Click the button once
		When I click "Add a Test" once
		Then a 2nd test entry should appear

	Scenario: Add multiple tests
		When I click "Add a Test" 10 times
		Then I should see 11 test entries

	Scenario: Add and delete second test
		When I click "Add a Test" once
		And I delete the 2nd test
		Then I should see only the tests: 1

	Scenario: Add a test and delete the first
		When I click "Add a Test" once
		And I delete the 1st test
		Then I should see only the tests: 2

	Scenario: Add and delete multiple tests
		When I click "Add a Test" 10 times
		And I delete tests: 2, 6, 7, 3
		Then I should see only the tests: 1, 4, 5, 8, 9, 10, 11