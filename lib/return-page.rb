# okpy test return page

require 'erb'

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
	template = File.open("./templates/return-page.erb").read()
	renderer = ERB.new(template)
	renderer.result((ReturnHTML.new(tests_text)).get_binding())
end