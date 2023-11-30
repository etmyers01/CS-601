/* Ed Myers
CS 601 - Assignment 5
main.js */

// acquire form elements for editing
const fileName = document.getElementById("jsonFile");   // file input field
const textOut = document.getElementById("textArea");    // text area field
const tableField = document.getElementById("tableSpace");    // table field

// acquire submit button and assign a click listener
const subButton = document.getElementById('submit');
subButton.onclick = getDoc;

// acquire clear button and assign a click listener
const clrButton = document.getElementById('clear');

// arrow function to clear text area and reset procedural HTML table
clrButton.onclick = () => 
{ 
    textOut.value = ''; 
    tableField.innerHTML = '<legend>Procedural HTML Table</legend>';
};      

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
        tableGen(data);                             // echo data to table generator
    }).catch((err) => {                             // catch error and update text
        textOut.value += `Fetch rejected: ${err}\n\n`;
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
    textOut.value += 'Creating dynamic HTML table below...\n\n'
}

// procedural table generator
function tableGen (data) {

    // function builds HTML to be inserted within the empty fieldset container

    // first output: write legend, start table tag and declare all of the column 
    //  labels in first row
    let htmlOut = 
    `
    <legend>Procedural HTML Table</legend>
    <table>
        <tr>
            <th></th>
            <th>School</th>
            <th>Program/Major</th>
            <th>Type</th>
            <th>Year Conferred</th>
        </tr>
    `;

    // second output, dynamically generate rows based on JSON object length,
    //  inserting school, major, type and year as horizontal table data
    for (let i = 0; i < data.college_degrees.length; ++i)
    {
        // create variable to reference degree-type object
        const degree = data.college_degrees[i];

        // generate full row output per element within college_degrees array
        htmlOut +=   
    `   <tr>
            <td>Degree #${i+1}</td>
            <td>${degree.school}</td>
            <td>${degree.program_major}</td>
            <td>${degree.type}</td>
            <td>${degree.year_conferred}</td>
        </tr>`;
    }

    // third output, close the table tag
    htmlOut += 
    `
    </table>
    `;

    // write full output string to empty fieldset using .innerHTML
    tableField.innerHTML = htmlOut;
}



