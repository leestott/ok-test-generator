#######################################
##### OkPy Test Generator Classes #####
#####       by Chris Pyles        #####
#######################################

# class for individual test case
class OkCase
	attr_accessor :code, :output, :hidden, :locked

	def initialize code, output, hidden, locked
		@code = code
		@output = output
		@hidden = hidden
		@locked = locked
	end

	def get_binding
		binding()
	end
end

# class for ok suites
class OkSuite
	attr_accessor :cases, :scored

	def initialize cases: [], scored: false
		@cases = cases
		@scored = scored
	end

	def add_case new_case
		@cases.push(new_case)
	end

	def get_binding
		binding()
	end
end

# class for ok tests
class OkTest
	attr_accessor :test_name, :points, :suites

	def initialize test_name, points, suites: []
		@test_name = test_name
		@points = points
		@suites = suites

		# iterate through suits
		for suite in suites

			# collect OkCase instances
			test_cases = []

			# iterate through cases
			for test_case in suite[:cases]

				# extract the array of code hashes, create new
				# OkCase instance
				code = test_case[:code]
				cases = []

				for code_hash in code 
					curr_case = OkCase.new(code_hash[:code], code_hash[:output],
						code_hash[:hidden], code_hash[:locked])
					cases.push(curr_case)
				end

				# add the OkCase instance to test_cases
				test_cases.push(cases)
			end

			# push test_cases to the suites array
			@suites.push(test_cases)
		end
	end

	def get_binding
		binding()
	end
end
