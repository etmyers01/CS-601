/* Ed Myers
CS 601 - Assignment 5
main.js */

// acquire form elements for editing
const fileName = document.getElementById("jsonFile");   // file input field
const textOut = document.getElementById("textArea");    // text area field

// acquire submit button and assign a click listener
const subButton = document.getElementById('submit');
subButton.onclick = getDoc;

// acquire clear button and assign a click listener
const clrButton = document.getElementById('clear');
clrButton.onclick = () => { textOut.value = ''; };      // arrow function to clear text area

// performs the fetch operation to acquire the JSON file
function getDoc() {

    // text area notifications of fetch progress
    textOut.value += 'Submit clicked. attempting to locate file...\n\n';
    textOut.value += `File identified as:\n  ${fileName.value}\n\n`;
    textOut.value += 'Beginning fetch command...\n';

    // attempt fetch
    fetch(fileName.value).then((response) => {     // fetch out
        textOut.value += `Fetch resolved!\n\n`;     // update text
        return response.json();                     // promise returned
    }).then(data => {
        jsonParse(data);                           // send data to parser
    }).catch((err) => {                             // catch error and update text
        textOut.value += `fetch rejected: ${err}\n\n`;
    });
}

// JSON object parser
function jsonParse(data) {

    textOut.value += 'Data obtained:\n\n'           // update text

    // for all elements in the JSON object array
    for (let i = 0; i < data.college_degrees.length; ++i) {

        const degree = data.college_degrees[i];     // current degree-type object

        // update output with degree school, major, type and year conferred
        textOut.value +=
            `   School:  ${degree.school}\n` +
            `   Program/Major:  ${degree.program_major}\n` +
            `   Type:  ${degree.type}\n` +
            `   Year Conferred:  ${degree.year_conferred}\n\n`
    }
}



