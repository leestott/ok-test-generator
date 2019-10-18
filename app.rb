###################################################
##### Sinatra Handler for OkPy Test Generator #####
#####             by Chris Pyles              #####
###################################################

require 'sinatra'
require 'sinatra/flash'
require_relative './lib/generator.rb'

# app class for Sinatra
class App < Sinatra::Base

	enable :sessions

	# route to access homepage
	get "/" do
		page = erb :index
		session[:message] = nil
		page
	end

	# route to access CSS
	get "/assets/style.css" do
		content_type "text/css"
		File.read("./assets/style.css")
	end

	# route to access custom JavaScript
	get "/assets/core.js" do
		content_type "text/javascript"
		File.read("./assets/core.js")
	end

	# route to generate tests
	get "/generate" do
		# generate Python text
		@tests = create_suite params

		# search for test name
		@test_name = @tests.test_name

		# create Python file using ERB
		@py_file = erb :test

		# return the return page template
		erb :return_page
	end

end

if __FILE__ == $0
	# run app
	run App.run!
end