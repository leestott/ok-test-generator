/**
	JavaScript for OkPy Test Generator
*/

var caseTestCount = 1;

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
	divNode.classList.add("form-group", "col-md-6");
	divNode.id = "inputSet" + caseTestCount;

	// // Add script to create first input
	// scriptNode = document.createElement("SCRIPT");
	// scriptNode.innerHTML = "addLine(" + caseTestCount + ", true);";

	// Add first code input
	var firstInput = document.createElement("TEXTAREA");
	firstInput.classList.add("form-control", "code-input");
	firstInput.name = "caseCode" + caseTestCount; firstInput.placeholder = "Code";

	// // Add "Add a Line" button
	// var addLineButton = document.createElement("BUTTON");
	// addLineButton.innerHTML = "Add a Line"
	// addLineButton.classList.add("btn", "btn-light");
	// addLineButton.type = "button"; addLineButton.onclick = function() { addLine(caseTestCount); };
	
	// Add output container
	var secondInput = document.createElement("TEXTAREA");
	secondInput.classList.add("form-control", "code-input");
	secondInput.name = "caseOutput" + caseTestCount; secondInput.placeholder = "Output";

	// Add div for checkboxes
	var checkboxDiv = document.createElement("DIV");
	checkboxDiv.classList.add("row");
	
	// Add checkbox for hidden
	var hiddenDiv = document.createElement("DIV");
	hiddenDiv.classList.add("col-md-6", "cases-checkbox");
	checkboxDiv.appendChild(hiddenDiv);

	var hiddenInput = document.createElement("INPUT");
	hiddenInput.classList.add("form-check-input");
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
	lockedInput.classList.add("form-check-input");
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
	// divNode.appendChild(firstInput); divNode.appendChild(addLineButton); 
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

// // Function to add line to test case
// function addLine(testNum, firstAdd=false) {
// 	var test = document.querySelector("#inputSet" + testNum);
// 	var output = document.querySelector("#inputSet" + testNum + " input:last-of-type");
// 	var prevInput = document.querySelector("#inputSet" + testNum + " input:nth-last-of-type(2)");
// 	var prevButton = document.querySelector("#inputSet" + testNum + " button:nth-last-of-type(2)");

// 	if (!firstAdd) {
// 		prevButton.innerHTML = "Delete Line";
// 		prevButton.onclick = function() { test.removeChild(prevInput); test.removeChild(prevButton); };
// 	}

// 	var newInput = document.createElement("INPUT");
// 	newInput.classList.add("form-control", "code-input", "col-md-7");
// 	newInput.type = "text"; newInput.name = "caseCode" + testNum; newInput.placeholder = "Code";

// 	var newButton = document.createElement("BUTTON");
// 	newButton.innerHTML = "Add a Line"
// 	newButton.classList.add("btn", "btn-light", "col-md-4", "offset-md-1");
// 	newButton.type = "button"; newButton.onclick = function() { addLine(testNum); };

// 	test.insertBefore(newInput, output);
// 	test.insertBefore(newButton, output);
// }

// Function to delete a test case
function deleteTest(divSelector) {
	var caseContainer = document.querySelector("#case-container");
	var test = document.querySelector("#" + divSelector);
	caseContainer.removeChild(test);
}
