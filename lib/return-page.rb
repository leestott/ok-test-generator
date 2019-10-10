###########################################
##### OkPy Test Generator Output Page #####
#####         by Chris Pyles          #####
###########################################

require 'erb'

# create object to use for renderer that holds the text
# of the output Python file
class ReturnHTML
	attr_accessor :test_name, :tests_text

	def initialize test_name, tests_text
		@test_name = test_name
		@tests_text = tests_text
	end

	def get_binding
		binding
	end
end

def get_return_page test_name, tests_text
	# open template ERB file and create renderer
	template = File.open("./views/return-page.erb").read()
	renderer = ERB.new(template)

	# render the Python file
	renderer.result((ReturnHTML.new(test_name, tests_text)).get_binding())
end