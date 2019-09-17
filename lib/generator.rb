# Okpy test generator

require 'erb'
require_relative './test.rb'

template = File.open("./templates/test.erb").read()
renderer = ERB.new(template)

# suites input:
suites = [
	{
		:cases => [
			{
				:code => [
					{
						:code => "1 == 1",
						:output => "True"
					}
				]
			}
		]
	}
]

def write_tests test_name, suites, renderer
	curr_test = OkTest.new(test_name, suites)
	renderer.result(curr_test.get_binding())
end




# def create_suite params
# 	# extract stuff

# 	ok_tests = []
# 	for _ in _
# 		ok_tests.push(ok_test.new(test_name, code, output))
# 	end

# 	output = renderer.result()