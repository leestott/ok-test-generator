###################################################
##### Sinatra Handler for OkPy Test Generator #####
#####             by Chris Pyles              #####
###################################################

require 'sinatra'
require 'sinatra/flash'
require_relative './lib/generator.rb'
require_relative './lib/return-page.rb'

# app class for Sinatra
class App < Sinatra::Base

	enable :sessions

	# route to access homepage
	get "/" do
		%x(make clean) # defined  in the Makefile
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
		tests = create_suite params

		# search for test name
		test_name = tests.match /"name": "(.+)",/

		# create and write the Python file for dowload
		# create_python_file test_name[1], tests

		# render the HTML for the result page
		page = get_return_page test_name[1], tests
		page
	end

	get "/download/:test.py" do
		# return Python file for download
		File.read("./output-tests/" + params[:test] + ".py")
	end

	# route to download tests
	get "/download" do
		session[:message] = "No file to download!"
		redirect '/'
	end

end

# run app
run App.run!