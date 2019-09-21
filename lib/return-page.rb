###########################################
##### OkPy Test Generator Output Page #####
#####         by Chris Pyles          #####
###########################################

require 'erb'

# create object to use for renderer that holds the text
# of the output Python file
class ReturnHTML
	attr_accessor :tests_text

	def initialize tests_text
		@tests_text = tests_text
	end

	def get_binding
		binding
	end
end

def get_return_page tests_text
	# open template ERB file and create renderer
	template = File.open("./views/return-page.erb").read()
	renderer = ERB.new(template)

	# render the Python file
	renderer.result((ReturnHTML.new(tests_text)).get_binding())
end