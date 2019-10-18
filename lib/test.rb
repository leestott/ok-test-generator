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
end

# class for ok tests
class OkTest
	attr_accessor :test_name, :points, :suites

	def initialize test_name, points, suites: []
		@test_name = test_name
		@points = points
		@suites = suites
	end
end
