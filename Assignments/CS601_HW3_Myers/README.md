## CS-601 - Edward Myers <br> Web Application Design

### Programs Used:
-   Visual Studio Code - MIT License

### Instructions:
-   All files must stay together in the file directory found in the CS601_HW3_Myers.zip file.  The primary launch page is intended to be index.html.
-   To initialize the calculator, press the button on the page and follow the prompts.

## Assignment #3 (JavaScript Calculator) 11/20/2023
Create a JavaScript calculator that prompts the user for several pieces of information, including their name and an array of numbers to perform calculations.  The output will be given in a series of prompts.  

### Features:
-   All pages have been passed through W3C and CSS validation without errors
-   All minimum requirements of the assignment are achieved.
-   The user inputs a list of numbers into the prompt all at once, rather than using a looping prompt train.
-   The program adds several extra alerts to demonstrate the status of the input values and utilizes some purposeful console.log outputs.

### Above & Beyond
-   The HTML uses a HTML5 button to intitialize the calculator, with an action listener and event handler set within the JavaScript file.
-   The HTML is stylized with a custom CSS, to give it an autumn flavor.
-   The CSS loads a background image, then gives it a slinky-style quality if the window is made wider or narrower.
-   The JavaScript:
    -   Uses ES6 datatypes
    -   Gives text output using the \'`${...}`\' inline formatting
    -   Uses several string methods, including .map, .split, .toLowerCase, .parseFloat
    -   Validates the user number input. Accounts for:
        -   Both commas and spaces or both
        -   Uses a regex experession within .split to parse all at once
        -   Tests for empty string entry
        -   Uses a separate custom made funtiton for error checking
        -   Casts the string to float numbers, then checks for presence of NaN to determine if non-numbers are present.
        -   Loops input prompt again if not all numbers.
    -   Outputs big/small observation for step #7 using an inline if/else statement built into the output.
    -   Validates the continue prompt, handling all forms of yes, no and an invalid entry.  If invalid, loops over again.


Thank you for your time, I hope you enjoy my submission.
