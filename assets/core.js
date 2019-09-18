/**
	JavaScript for OkPy Test Generator
*/

var caseTestCount = 1;

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
	
	divNode.appendChild(firstInput); divNode.appendChild(secondInput);
	
	caseContainer.appendChild(divNode);
}

function copyOutput() {
	var copyText = document.querySelector("#output-text");
	copyText.select();
	copyText.setSelectionRange(0, 99999);
	document.execCommand("copy");

	var copyButton = document.querySelector("#copy-button")
	copyButton.innerHTML = "Copied!";
}