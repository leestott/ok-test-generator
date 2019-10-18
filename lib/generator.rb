################################
##### OkPy Tests Generator #####
#####    by Chris Pyles    #####
################################

require 'erb'
require_relative './test.rb'

def create_test_obj params
	# create an OkTest instance for the test
	curr_test = OkTest.new(params[:testname], params[:points])

	# create a suite
	scored = !params[:scored].nil?
	curr_suite = OkSuite.new(scored: scored)

	# push suite to this test case
	curr_test.suites << curr_suite

	# remove params for iteration below
	params.delete(:testname); params.delete(:points); params.delete(:scored)

	# iterate through params, collect in curr_suite
	curr_case = {
		:code => nil,
		:output => nil,
		:hidden => false,
		:locked => false
	}
	params.each { |key, value|

		if key.include?("Code") && !curr_case[:output].nil?
			# add a new OkCase instance to the suite
			curr_suite.cases << OkCase.new(
				curr_case[:code],
				curr_case[:output],
				curr_case[:hidden],
				curr_case[:locked]
			)

			# reset the curr_case hash
			curr_case = {
				:code => nil,
				:output => nil,
				:hidden => false,
				:locked => false
			}
		end

		if key.include? "Code"
			curr_case[:code] = value
		elsif key.include? "Output"
			curr_case[:output] = value
		elsif key.include? "hidden"
			curr_case[:hidden] = true
		elsif key.include? "locked"
			curr_case[:locked] = true
		end

	}

	# add in final test case
	curr_suite.cases << OkCase.new(
				curr_case[:code],
				curr_case[:output],
				curr_case[:hidden],
				curr_case[:locked]
			)

	return curr_test
end

def create_suite params
	# create the code => output hash
	curr_test = create_test_obj(params)
	return curr_test
end