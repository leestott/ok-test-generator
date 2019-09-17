# test case class

# # suites input:
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

class OkTest
	attr_accessor :test_name, :suites

	def initialize test_name, suites
		@test_name = test_name
		@suites = []

		for suite in suites
			test_cases = []
			for test_case in suite[:cases]
				code = test_case[:code]
				curr_case = OkCase.new([])
				for code_pair in code
					curr_case.add_case(TestCase.new(code_pair[:code], 
						code_pair[:output]))
				end
				test_cases.push(curr_case)
			end
			@suites.push(test_cases)
		end
	end

	def get_binding
		binding()
	end
end

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