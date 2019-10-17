@javascript
Feature: generate test cases

	Background:
		Given I am viewing "/"

	Scenario: generate simple test
		When I create a 1 point unscored test "q1_1":
		| code 	 | output | hidden | locked |
		| 1 == 1 | True   | false  | false  |
		| 1 == 2 | False  | false  | false  |
		| 1 != 2 | True   | true   | false  |
		| 1 != 3 | True   | false  | true   |
		| True   | True   | true   | true   |
		And I click "Submit" once
		Then I should be on "/generate"
		And I should see the prompts:
		| prompt | output |
		| 1 == 1 | True   |
		| 1 == 2 | False  |
		| 1 != 2 | True   |
		| 1 != 3 | True   |
		| True   | True   |

	Scenario: generate test with points field blank
		When I create a no point unscored test "q1":
		| code 	 | output | hidden | locked |
		| 1 == 1 | True   | false  | false  |
		And I click "Submit" once
		Then I should be on "/generate"
		And I should see the prompts:
		| prompt | output |
		| 1 == 1 | True   |

	# Scenario: try to leave test name field blank
	# 	Given I am viewing "/"
	# 	When I click "Submit" once
	# 	Then I should be on "/"
	# 	And I should see "Please fill out this field."

	Scenario: leave non-required inputs blank
		When I create a no point unscored test "q1":
		| code 	 | output | hidden | locked |
		And I click "Submit" once
		Then I should be on "/generate"
		And I should see an empty test

	Scenario: test that tab is captured in code inputs
		When I press "tab" in the code input
		Then I should be on "/"
		And there should be a "	" character in the code input

	Scenario: tes that tab is captured in output inputs
		When I press "tab" in the output input
		Then I should be on "/"
		And there should be a "	" character in the output input