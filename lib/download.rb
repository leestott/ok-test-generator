#############################################
##### OkPy Test Generator Download Page #####
#####          by Chris Pyles           #####
#############################################

def create_python_file test_name, tests_text
	File.open("output-tests/" + test_name + ".py", "w+") { |f|
		f.write(tests_text)
	}
end

# def get_download_page test_name, tests_text
# 	create_python_file test_name, tests_text
# 	return tests_text
# end