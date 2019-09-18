# Okpy test generator

require 'erb'
require_relative './test.rb'

# # suites input:
# suites = [
# 	{
# 		:cases => [
# 			{
# 				:code => [
# 					{
# 						:code => "1 == 1",
# 						:output => "True"
# 					}
# 				]
# 			}
# 		]
# 	}
# ]

def write_tests test_name, suites, renderer
	curr_test = OkTest.new(test_name, suites)
	renderer.result(curr_test.get_binding())
end

def query_to_hash params
	code_hash = {}

	curr_code, curr_output = nil, nil
	params.each { |key, value|
		if key == "testName"
			next
		end
		if curr_code.nil?
			curr_code = value
		else
			curr_output = value
		end

		if !curr_output.nil?
			code_hash[curr_code] = curr_output
			curr_code, curr_output = nil, nil
		end
	}

	return code_hash
end

def create_suite params
	test_case_hash = query_to_hash(params)
	suites = [{:cases => [{ :code => []}]}]
	code_arr = suites[0][:cases][0][:code]
	test_case_hash.each { |code, output|
		code_arr.push({
			:code => code,
			:output => output
		})
	}

	template = File.read("./templates/test.erb")
	renderer = ERB.new(template)

	finished_test = write_tests(params[:testName], suites, renderer)

	return finished_test
end