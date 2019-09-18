/**
	JavaScript for OkPy Test Generator
*/

var caseTestCount = 1;

function addCaseTest() {
	caseContainer = document.querySelector("#case-container");
	caseTestCount++;

	divNode = document.createElement("DIV");
	divNode.classList.add("form-group", "col-md-4");

	firstInput = document.createElement("INPUT");
	firstInput.classList.add("form-control", "code-input");
	firstInput.type = "text"; firstInput.name = "caseCode" + caseTestCount; firstInput.placeholder = "Code";
	
	secondInput = document.createElement("INPUT");
	secondInput.classList.add("form-control", "code-input");
	secondInput.type = "text"; secondInput.name = "caseOutput" + caseTestCount; secondInput.placeholder = "Output";
	
	divNode.appendChild(firstInput); divNode.appendChild(secondInput);
	
	caseContainer.appendChild(divNode);
}