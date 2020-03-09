/**
	JavaScript for OkPy Test Generator
*/

var caseTestCount = 1;
var test = {};
var testTemplate = _.template(`test = {
	"name": "<%= name %>",
	"points": <%= points ? points : 0 %>,
	"hidden": <%= hidden ? "True" : "False" %>,
	"suites": [ <% cases = suites[0].cases %>
		{
			"cases": [ <% _(cases).each((testCase) => { %>
				{
					"code": r"""<% if (testCase.code.length != 1 || testCase.code[0] != "") { 
						_(testCase.code).each((line, i) => { %>
					<%= i != 0 && (line.startsWith("\t") || line.startsWith("  ")) ? "..." : ">>>" %> <%= line %><% }); }
					if (testCase.output.length != 1 || testCase.output[0] != "") { _(testCase.output).each((line, i) => { %>
					<%= line %><% }); } %>
					""",
					"hidden": <%= testCase.hidden ? "True" : "False" %>,
					"locked": <%= testCase.locked ? "True" : "False" %>,
				}, <% }); %>
			],
			"scored": <%= scored ? "True" : "False" %>,
			"setup": "",
			"teardown": "",
			"type": "doctest"
		}
	]
}`);
var outputTemplate = _.template(`<div id="results">

<h4>Here is your test!</h4>

<p>Put it in a Python executable and get ready to use ok!</p>

<textarea class="generated-file" id="output-text" readonly><%= renderedTest %></textarea>

<div class="row">
	<div class="col-md-4 offset-md-4">
		<a id="download-btn"><button type="button" id="copy-button" class="btn btn-light return-button">Download</button></a>
	</div>
	<!-- <div class="col-md-3">
		<a href="./"><button type="button" class="btn btn-light return-button">Generate Another Test</button></a>
	</div> -->
</div>

<script type="text/javascript">
	setupDownload("<%= testName %>.py");
</script>

</div>`);

// Function to capture the TAB key in all textareas
function captureTabKey() {
	var textareas = document.getElementsByTagName('textarea');
	var count = textareas.length;
	for(var i=0; i<count; i++){
	    textareas[i].onkeydown = function(e){
	        if(e.keyCode==9 || e.which==9){
	            e.preventDefault();
	            var s = this.selectionStart;
	            this.value = this.value.substring(0,this.selectionStart) + "\t" + this.value.substring(this.selectionEnd);
	            this.selectionEnd = s+1; 
	        }
	    }
	}
}

// Function to add sections to form for new test cases
function addCaseTest() {
	var caseContainer = document.querySelector("#case-container");
	caseTestCount++;

	// Create div container for inputs
	var divNode = document.createElement("DIV");
	divNode.classList.add("form-group", "col-md-6", "case");
	divNode.id = "inputSet" + caseTestCount;

	// Add first code input
	var firstInput = document.createElement("TEXTAREA");
	firstInput.classList.add("form-control", "code-input", "code");
	firstInput.name = "caseCode" + caseTestCount; firstInput.placeholder = "Code";
	
	// Add output container
	var secondInput = document.createElement("TEXTAREA");
	secondInput.classList.add("form-control", "code-input", "output");
	secondInput.name = "caseOutput" + caseTestCount; secondInput.placeholder = "Output";

	// Add div for checkboxes
	var checkboxDiv = document.createElement("DIV");
	checkboxDiv.classList.add("row");
	
	// Add checkbox for hidden
	var hiddenDiv = document.createElement("DIV");
	hiddenDiv.classList.add("col-md-6", "cases-checkbox");
	checkboxDiv.appendChild(hiddenDiv);

	var hiddenInput = document.createElement("INPUT");
	hiddenInput.classList.add("form-check-input", "hidden");
	hiddenInput.type = "checkbox"; hiddenInput.name = "hidden" + caseTestCount; hiddenInput.id = "hidden" + caseTestCount;
	var hiddenLabel = document.createElement("LABEL");
	hiddenLabel.classList.add("form-check-label");
	hiddenLabel.for = "hidden1"; hiddenLabel.innerHTML = "Hidden"
	hiddenDiv.appendChild(hiddenInput); hiddenDiv.appendChild(hiddenLabel);

	// Add checkbox for locked
	var lockedDiv = document.createElement("DIV");
	lockedDiv.classList.add("col-md-6", "cases-checkbox");
	checkboxDiv.appendChild(lockedDiv);

	var lockedInput = document.createElement("INPUT");
	lockedInput.classList.add("form-check-input", "locked");
	lockedInput.type = "checkbox"; lockedInput.name = "locked" + caseTestCount; lockedInput.id = "locked" + caseTestCount;
	var lockedLabel = document.createElement("LABEL");
	lockedLabel.classList.add("form-check-label");
	lockedLabel.for = "locked1"; lockedLabel.innerHTML = "Locked"
	lockedDiv.appendChild(lockedInput); lockedDiv.appendChild(lockedLabel);

	// Add "Delete Test" button
	var deleteButton = document.createElement("BUTTON");
	deleteButton.innerHTML = "Delete Test"
	deleteButton.classList.add("btn", "btn-light", "offset-md-1", "col-md-10");
	deleteButton.type = "button"; deleteButton.onclick = function() { deleteTest(deleteButton.parentNode.id); };

	// Append children
	divNode.appendChild(firstInput);
	divNode.appendChild(secondInput); divNode.appendChild(checkboxDiv);
	divNode.appendChild(document.createElement("BR")); divNode.appendChild(deleteButton);
	
	caseContainer.appendChild(divNode);

	captureTabKey();
}

// Function to copy test output
function copyOutput() {
	var copyText = document.querySelector("#output-text");
	copyText.select();
	copyText.setSelectionRange(0, 99999);
	document.execCommand("copy");

	var copyButton = document.querySelector("#copy-button")
	copyButton.innerHTML = "Copied!";
}

// Function to download test file
function setupDownload(filename) {
	var text = document.querySelector("#output-text").value;
	var btn = document.querySelector("#download-btn");
	btn.setAttribute("href", "data:text/plain;charset=utf-8," + encodeURIComponent(text));
	btn.setAttribute("download", filename)
}

// Function to delete a test case
function deleteTest(divSelector) {
	var caseContainer = document.querySelector("#case-container");
	var test = document.querySelector("#" + divSelector);
	caseContainer.removeChild(test);
}

// Function to create an object representing the test
function testToObject() {
	var cases = $(".case");
	test = {
		name: $("[name='testname']").val(),
		points: $("[name='points']").val(),
		scored: $("[name='scored']").prop("checked"),
		hidden: !$("input#visible").prop("checked"),
		suites: [{
			cases: []
		}]
	};
	cases.each((index, testCase) => {
		var thisCase = {
			code: $(testCase).find(".code").val().split("\n"),
			output: $(testCase).find(".output").val().split("\n"),
			hidden: $(testCase).find(".hidden").prop("checked"),
			locked: $(testCase).find(".locked").prop("checked")
		}
		test.suites[0].cases.push(thisCase);
	});
}

// Function to render testTemplate
function renderTest() {
	testToObject();
	return testTemplate(test);
}

// Generates the test and adds the textarea
function generateTest() {
	$("div#results").remove();
	var outputHTML = outputTemplate({
		renderedTest: renderTest(),
		testName: test.name
	});
	$(outputHTML).appendTo($("div#body"));
}
