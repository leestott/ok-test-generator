###################################################
##### Sinatra Handler for OkPy Test Generator #####
#####             by Chris Pyles              #####
###################################################

require 'sinatra/base'
require_relative './generator.rb'
require_relative './return-page.rb'

# app class for Sinatra
class App < Sinatra::Base

	# route to access homepage
	get "/" do
		File.read("./index.html")
	end

	# route to access CSS
	get "/assets/style.css" do
		content_type "text/css"
		File.read("./assets/style.css")
	end

	# route to access custom JavaScript
	get "/assets/addCases.js" do
		content_type "text/javascript"
		File.read("./assets/addCases.js")
	end

	# route to generate tests
	get "/generate" do
		tests = create_suite params
		get_return_page tests
	end

end

# run app
run App.run!