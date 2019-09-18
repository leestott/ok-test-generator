# test handler

require 'sinatra/base'
require_relative './generator.rb'
require_relative './return-page.rb'

class App < Sinatra::Base

	# set :public_folder, File.join(File.dirname(__FILE__), "assets")

	get "/" do
		File.read("./index.html")
	end

	get "/assets/style.css" do
		content_type "text/css"
		File.read("./assets/style.css")
	end

	get "/assets/addCases.js" do
		content_type "text/javascript"
		File.read("./assets/addCases.js")
	end

	get "/generate" do
		tests = create_suite params
		get_return_page tests
	end

end

run App.run!