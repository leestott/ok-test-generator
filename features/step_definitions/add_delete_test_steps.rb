Given /I am viewing "(.*)"/ do |url|
	visit(url)
end

When /I click "(.*)" once/ do |button|
	click_on(button)
end

When /I click "(.*)" (\d+) times/ do |button, n|
	for _ in 0...n
		steps %{
			When I click "#{button}" once
		}
	end
end

Then /I should see (\d+) test entries/ do |n|
	for i in 1..n
		steps %{
			an #{n}th test entry should appear
		}
	end
end

Then /an? (\d+)\w{2} test entry should appear/ do |n|
	expect(page).to have_selector("div#inputSet#{n}")
end

Then /there should not be an? (\d+)\w{2} test entry/ do |n|
	expect(page).not_to have_selector("div#inputSet#{n}")
end

When /I delete the (\d+)\w{2} test/ do |n|
	find("#inputSet#{n}").click_on("Delete Test")
end

When /I delete tests: (.*)/ do |tests|
	tests = tests.split(/\s*,\s*/)
	tests.map! do |i| i.to_i end
	tests.each do |i|
		steps %{
			When I delete the #{i}th test
		}
	end
end

Then /I should see only the tests: (.*)/ do |tests|
	tests = tests.split(/\s*,\s*/)
	tests.map! do |i| i.to_i end
	(tests.max() + 5).times do |i|
		if tests.include? i
			steps %{
				Then an #{i}th test entry should appear
			}
		else
			steps %{
				Then there should not be an #{i}th test entry
			}
		end
	end
end