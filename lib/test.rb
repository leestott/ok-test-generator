#######################################
##### OkPy Test Generator Classes #####
#####       by Chris Pyles        #####
#######################################

# # Structure of suites array
# suites = [
# 	{
# 		:cases: [
# 			{
# 				:code: [
# 					{
# 						:code: code,
# 						:output: output
# 					}
# 				]
# 			}
# 		]
# 	}
# ]

# class for ok tests
class OkTest
	attr_accessor :test_name, :suites

	def initialize test_name, suites
		@test_name = test_name
		@suites = []

		# iterate through suits
		for suite in suites

			# collect OkCase instances
			test_cases = []

			# iterate through cases
			for test_case in suite[:cases]

				# extract the array of code hashes, create new
				# OkCase instance
				code = test_case[:code]
				curr_case = OkCase.new([])

				# iterate through hashes
				for code_pair in code

					# create new TestCase instance for code_pair
					curr_case.add_case(TestCase.new(code_pair[:code], 
						code_pair[:output]))
				end

				# add the OkCase instance to test_cases
				test_cases.push(curr_case)
			end

			# push test_cases to the suites array
			@suites.push(test_cases)
		end
	end

	def get_binding
		binding()
	end
end

# class for individual set of cases
class OkCase
	attr_accessor :cases

	def initialize cases
		@cases = cases
	end

	def add_case new_case
		cases.push(new_case)
	end

	def get_binding
		binding()
	end
end

# class for individual test (meaning code => output pair)
class TestCase 
	attr_accessor :code, :output

	def initialize code, output
		@code = code
		@output = output
	end

	def get_binding
		binding()
	end
end