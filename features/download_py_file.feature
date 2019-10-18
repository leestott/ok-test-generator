@javascript
Feature: download .py file

	Background:
		Given I am viewing "/"
		And I create a 1 point unscored test "q1_1":
		| code 	 | output | hidden | locked |
		| 1 == 1 | True   | false  | false  |
		| 1 == 2 | False  | false  | false  |
		| 1 != 2 | True   | true   | false  |
		| 1 != 3 | True   | false  | true   |
		| True   | True   | true   | true   |

	Scenario: check download link for a simple test
		When I click "Submit" once
		Then I should be on "/generate"
		And I should see a download link with prompts:
		| prompt | output |
		| 1 == 1 | True   |
		| 1 == 2 | False  |
		| 1 != 2 | True   |
		| 1 != 3 | True   |
		| True   | True   |