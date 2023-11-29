/* Ed Myers
CS 601 - Assignment 4
main.js */

// launch validity checker upon load
//window.onload = isAllValid;

// acquire form container, store and attach listener
//const currForm = document.getElementById('assign4');
//currForm.oninput = isAllValid;

// acquire form elements and store for manipulation

const subButton = document.getElementById('submit');
subButton.onclick = getDoc;

const textOut = document.getElementById("textArea");

function getDoc()   {
    textOut.value += 'Submit clicked... attempting to locate file.\n';
}

/*
const fac = document.getElementById("facilitator");     // facilitator
const facError = document.getElementById("facError");       // facilitator error output
const subButton = document.getElementById('submit');    // submit button
const fName = document.getElementById('firstName');     // first name
const fNameError = document.getElementById('fNameError');   // first name error output
const lName = document.getElementById('lastName');      // last name
const lNameError = document.getElementById('lNameError');   // last name error output
const radioChoice = document.getElementsByName('radioGroup');   // radio button group
const radioError = document.getElementById('radioError');   // radio button error output
const checkBox = document.querySelectorAll('input[type=checkbox]'); // check box group
const checkError = document.getElementById('checkError');   // check box error output
*/

// checks validity of passed name input field, edits errors and CSS. returns true/false;
// (Part 2.A of assignment)

/*
function isNameValid(localName, localError) {
    // regex check
    const regex = new RegExp('^[a-zA-Z]+$');

    // if value is less than 2 characters in length, set error message, CSS and return false
    if (localName.value.length < 2) {
        localError.innerText = 'First name input must contain a minimum of two characters.';
        localName.style.outline = '2px solid red';
        return false;
    }
    // else if value does not match regex, set error message, CSS and return false
    else if (!regex.test(localName.value)) {
        localError.innerText = 'Content must use letters only.';
        localName.style.outline = '2px solid red';
        return false;
    }
    // the result is good, clear error message, set good CSS and return true
    else
        localError.innerText = '';
    localName.style.outline = '2px solid green';
    return true;
}

// checks validity of passed selection field, edits errors and CSS. returns true/false;
function isSelectionValid(localSelect, localError) {
    let selected = false;       // boolean tracker

    // loops through each select option array and determines if any are checked
    for (let i = 0; i < localSelect.length; ++i) {
        if (localSelect[i].checked) {       // if checked, set tracker to true
            selected = true;
            break;
        }
    }

    // if an option is selected, clear error message.  otherwise set error message.
    localError.innerText = `${(selected) ? '' : 'Please select an option.'}`

    return selected;            // return validity check
}

// create a compare array of valid string inputs for the facilitator field
const comp = ['Jen', 'Behdad', 'Chris', 'Christian', 'Josh'];

// facilitator validity funciton (Part 2.B of assignment)
// - determines if contents of facilitator text field equal any entry in the comp array
// - returns true or false
function isFacValid() {
    // string method .includes to check per array element
    if (!comp.includes(fac.value))      // if not equal to any
    {
        // style a red border around the field, update the error readout
        fac.style.outline = '2px solid red';
        facError.innerText = `The facilitator must be one of the following:\n[ ${comp.join(', ')} ]`;
        return false;                // false means not within array
    }
    
    // if finds an equal, style a green border around the field
    fac.style.outline = '2px solid green';
    facError.innerText = '';
    return true;                 // true means match found in array
    
}

// overall validity function (Part 2.D of assignment)
// - determines if the form is reporting that all fields are valid
// - sets submit button disabled status and styling cues
function isAllValid() {
    const fN = isNameValid(fName, fNameError);            // is first name valid
    const lN = isNameValid(lName, lNameError);            // is last name valid
    const fC = isFacValid();                              // is facilitator valid
    const rG = isSelectionValid(radioChoice, radioError); // are radio buttons selected
    const cG = isSelectionValid(checkBox, checkError);    // are checkboxes selected

    if (fN && lN && fC && rG && cG)      // if all return as true
    {
        subButton.disabled = false;        // enable submit button
        subButton.value = 'Submit';        // change button text to 'submit'
    }
    else                                // if one or more are false
    {
        subButton.disabled = true;        // disble submit button
        subButton.value = 'Disabled';
    }     // change button text to 'disbled'
}
*/