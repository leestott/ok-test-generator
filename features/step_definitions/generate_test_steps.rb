# require_relative './add_delete_test_steps.rb'

When /^I create an? (\S+) point (un)?scored test "(\w+)":$/ do |points, unscored, test_name, test_table|
	fill_in "Test Name", with: test_name
	if !(points == "no" || points == "zero") && points.to_i != 0
		fill_in "Points", with: points
	end
	if !unscored
		find("#scored").set(true)
	end
	case_count = 1
	test_table.hashes.each do |test_case|
		fill_in "caseCode#{case_count}", with: test_case[:code]
		fill_in "caseOutput#{case_count}", with: test_case[:output]
		if test_case[:hidden]
			find("#hidden#{case_count}").set(true)
		end
		if test_case[:locked]
			find("#locked#{case_count}").set(true)
		end
		case_count += 1
		steps %{
			When I click "Add a Test" once
		}
	end
end

Then /^I should be on "(.+)"$/ do |url|
	expect(page).to have_current_path(url, ignore_query: true)
end

Then /^I should see the prompts:$/ do |prompts|
	text_area = find("#output-text")
	prompts.hashes.each do |prompt|
		regexp = Regexp.new(">>> #{prompt[:prompt]}\n\t{5}#{prompt[:output]}")
		expect(text_area).to have_content(regexp)
	end
end

Then /^I should see "(.*)"$/ do |message_text|
	# expect(page).to have_content(message)
	message = page.find("form#test-generator input:nth-of-type(1)").native.attribute("validationMessage")
  expect(message).to eq message_text
end

Then /^I should see an empty test$/ do
	regexp = /"code": r"""\n\t{5}"""/
	text_area = find("#output-text")
	expect(text_area).to have_content(regexp)
end

When /^I press "(\w+)" in the (code|output) input$/ do |char, inp|
	if inp == "code"
		input = find("#inputSet1 textarea:nth-of-type(1)")
	elsif inp == "output"
		input = find("#inputSet1 textarea:nth-of-type(2)")
	end
	input.native.send_keys(char.to_sym)
end

Then /^there should be a "([\s\w\d])" character in the (code|output) input$/ do |char, inp|
	if inp == "code"
		input = find("#inputSet1 textarea:nth-of-type(1)")
	elsif inp == "output"
		input = find("#inputSet1 textarea:nth-of-type(2)")
	end
	expect(input.value).to eq char
end
