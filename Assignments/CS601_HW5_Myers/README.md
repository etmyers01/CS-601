## CS-601 - Edward Myers <br> Web Application Design

### Programs Used:
-   Visual Studio Code - MIT License

### Instructions:
-   All files must stay together in the file directory found in the CS601_HW4_Myers.zip file.  The primary launch page is intended to be index.html.
-   From the beginning, the submit button is disabled.  The user must provide input in compliance with the error readouts across all fields for the submit button to enable.

## Assignment #4 (JavaScript Forms & Event Handling) 11/27/2023
Create a JavaScript form that provides HTML & JavaScript input validation with thoughtful error notification and styling.  The form must successfully POST to a receiving script with confirmation. 

### Features:
-   All pages have been passed through W3C and CSS validation without errors
-   **Issue** : I had significant trouble installing and configuring ESLint, so I linted the JS code with three other linting extensions available through VSCode.
-   The code does all data validation through JS functions.  Name validation was performed using string length and regex string comparisons.  Facilitator validation was performed using the array .contains method.

### Above & Beyond
-   The JS sets up an event listener for the entire form, initialized at the point of window load.  The submit button is disabled on start, requiring the user to fix all form errors prior to the button becoming operable.
-   The form listener uses .oninput, which provides a change of state event for any component within the form.  That trigger is tied to a custom validity function that fires upon each form edit.
-   The web page is styled nicely in CSS, with thoughtful color and error message changes on the fly to provide the user with visual cues to the correctness of the input.  
-   The radio and checkbox groups also have JS validity checking, requiring the user to select an option before continuing.  
-   To be blatant, the submit button starts out disabled, red and has the button text 'disabled' across the front.  All of these states change when the button enables.


Thank you for your time, I hope you enjoy my submission.
