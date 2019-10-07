/**
	JavaScript for OkPy Test Generator
*/

var caseTestCount = 1;

// Function to add sections to form for new test cases
function addCaseTest() {
	var caseContainer = document.querySelector("#case-container");
	caseTestCount++;

	var divNode = document.createElement("DIV");
	divNode.classList.add("form-group", "col-md-4");

	var firstInput = document.createElement("INPUT");
	firstInput.classList.add("form-control", "code-input");
	firstInput.type = "text"; firstInput.name = "caseCode" + caseTestCount; firstInput.placeholder = "Code";
	
	var secondInput = document.createElement("INPUT");
	secondInput.classList.add("form-control", "code-input");
	secondInput.type = "text"; secondInput.name = "caseOutput" + caseTestCount; secondInput.placeholder = "Output";

	var checkboxDiv = document.createElement("DIV");
	checkboxDiv.classList.add("row");
	
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

	divNode.appendChild(firstInput); divNode.appendChild(secondInput); divNode.appendChild(checkboxDiv);
	
	caseContainer.appendChild(divNode);
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