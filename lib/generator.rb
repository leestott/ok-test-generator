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
# 						:output => "True",
#						:hidden => true,
#						:locked => false
# 					}
# 				]
# 			}
# 		],
#		:scored => true
# 	}
# ]

def write_tests test_name, points, scored, suites, renderer
	# create OkTest object from suites
	curr_test = OkTest.new(test_name, points, scored, suites)

	# use renderer to rend ERB file
	renderer.result(curr_test.get_binding())
end

def query_to_hash params
	# create a hash to collect the code => output pairs
	code_hash = {}

	# iterate through code, output pairs in params,
	# collect in code_hash
	curr_code, curr_output, curr_hidden, curr_locked = nil, nil, false, false
	params.each { |key, value|

		# do not include the testname parameter
		if key == "testname" || key == "points" || key == "scored"
			next
		end

		if key.include?("Code") && !curr_output.nil?
			code_hash[curr_code] = {
				:output => curr_output,
				:hidden => curr_hidden,
				:locked => curr_locked
			}
			curr_code, curr_output, curr_hidden, curr_locked = nil, nil, false, false
		end

		if key.include? "Code"
			curr_code = value
		elsif key.include? "Output"
			curr_output = value
		elsif key.include? "hidden"
			curr_hidden = true
		elsif key.include? "locked"
			curr_locked = true
		end

		# if we are in output, put the pair into the hash
		# and reset them
		if curr_locked
			code_hash[curr_code] = {
				:output => curr_output,
				:hidden => curr_hidden,
				:locked => curr_locked
			}
			curr_code, curr_output, curr_hidden, curr_locked = nil, nil, false, false
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
	test_case_hash.each { |code, contents|
		code_arr.push({
			:code => code,
			:output => contents[:output],
			:hidden => contents[:hidden],
			:locked => contents[:locked]
		})
	}

	# load the test template ERB file and renderer
	template = File.read("./templates/test.erb")
	renderer = ERB.new(template)

	# render the ok test
	finished_test = write_tests(params[:testname], params[:points], params.key?(:scored), suites, renderer)

	return finished_test
end