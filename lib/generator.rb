################################
##### OkPy Tests Generator #####
#####    by Chris Pyles    #####
################################

require 'erb'
require_relative './test.rb'

# # Structure of suites array
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
	# create OkTest object from suites
	curr_test = OkTest.new(test_name, suites)

	# use renderer to rend ERB file
	renderer.result(curr_test.get_binding())
end

def query_to_hash params
	# create a hash to collect the code => output pairs
	code_hash = {}

	# iterate through code, output pairs in params,
	# collect in code_hash
	curr_code, curr_output = nil, nil
	params.each { |key, value|

		# do not include the testName parameter
		if key == "testName"
			next
		end

		# check if last parameter was code or output
		if curr_code.nil?
			curr_code = value

		# if it was code, this parameter is output
		else
			curr_output = value
		end

		# if we are in output, put the pair into the hash
		# and reset them
		if !curr_output.nil?
			code_hash[curr_code] = curr_output
			curr_code, curr_output = nil, nil
		end
	}

	return code_hash
end

def create_suite params
	# create the code => output hash
	test_case_hash = query_to_hash(params)

	# initialize the suites structure described above
	suites = [{:cases => [{ :code => []}]}]

	# select the array that holds the hash of code => output
	# pairs
	code_arr = suites[0][:cases][0][:code]

	# iterate through code => output pairs and put into the
	# list of hashes in the suite
	test_case_hash.each { |code, output|
		code_arr.push({
			:code => code,
			:output => output
		})
	}

	# load the test template ERB file and renderer
	template = File.read("./templates/test.erb")
	renderer = ERB.new(template)

	# render the ok test
	finished_test = write_tests(params[:testName], suites, renderer)

	return finished_test
end