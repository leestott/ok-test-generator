require 'uri'

Then /^I should see a download link with prompts:$/ do |prompts_table|
	prompts_table.hashes.each do |prompt|
		regexp_string = "\t" * 5 + ">>> #{prompt[:prompt]}\n"
		regexp_string += "\t" * 5 + "#{prompt[:output]}"
		uri_string = URI::encode(regexp_string)
		uri_string.gsub!(/=/, "%3D")
		expect(page).to have_link(href: Regexp.new(uri_string))
	end
end