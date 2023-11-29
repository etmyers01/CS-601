/*  main.js
    CS 601, Assignment #3
    Ed Myers
*/

// preloading check

function ready (fn) {
    if (document.readyState !== 'loading')  {
        fn();
    } else {
        document.addEventListener('DOMContentLoaded', fn);
    }
}

// action listener associated with a button object in the HTML.  Sets the fire condition to execute the
// JavaScript in the function arrayProgram below.

ready( () => 
{   
    const btn = document.querySelector("button");
    btn.addEventListener("click", arrayProgram);
}
)

// core calculator program

function arrayProgram ()
{
    // Step #1 - Welcomes the visitor with an alert
    
    alert('Step #1 : Welcome to my page!')

    // Step #2 - Prompts the visitor for his/her name
    let userName = prompt('Step #2 : Please enter your name: ')

    // Step #3 - Displays the visitor's name with an alert
    alert(` Step #3 : Welcome ${userName}!`)

    // boolean to determine Step #8, repetition of Steps 4-7.
    let proceed = false

    do
    {   
        /* Step #4 - Asks the visitor to enter a list of numbers (positve and negatve numbers are
            allowed) with a prompt

            a. The visitor can enter one number with one prompt unAl the visitor clicks
            cancel or enters a senAnel value to stop, or you can ask the visitor to enter all
            the numbers in one prompt, separated by a space or comma.

            b. Store these numbers into an array */

        // error tracking function isValid.
        //  - returns true if all values are valid numbers
        //  - returns false if empty or contains non-numbers    
        function isValid (strArr)
        {
            // if empty string, return false
            if (strArr.length == 0)  { console.log ("empty"); return false; }

            // attempt to convert to numbers.  non-numbers turn into NaN.
            arr = strArr.map(parseFloat)

            // check every element.  if NaN exists, there is a non-number so return false
            for (let i = 0; i < arr.length; ++i)
            {   
                // console log entry for correctness check
                if ( isNaN(arr[i]) )    { console.log ("NaN exists"); return false; }
            }

            // if all numbers, create a console log entry and return true
            console.log ("good array all numbers")
            return true;
        }

        // create an array visible into the following input loop
        let strArray = new Array();

        // perform a prompt at least once, asking for a list of numbers separated by space or comma or both
        do {
            let inputStr = prompt('Step #4 : Please enter a series of positive or negative numbers, separated by comma or space, and click OK')
            // use a regex with split to split on both ',' and ' '
            strArray = inputStr.split(/[\s,]+/)
        }
        // checks for not false return from isValid validity check
        while (!isValid(strArray))

        // output confirmation
        alert ("You have succeeded in entering all numbers in Step #4, good job!")

        /* Step #5 - Uses a functon (that you create) to perform the following actons:
            a. Iterates through the array of numbers the visitor entered.

            b. Compares the current number and the next number (if any) in the array. If
            the current number is larger than or equal to the next number, then add the
            current number to a new array. Repeat this process for all numbers in the
            array. The last number in the array is always included in the new array.

            c. Adds all the numbers in the new array together and returns the total. */

        // create num array from string array for remaining steps.  it will work because it was previously validated.    
        let numArray = strArray.map(parseFloat)
        // output confirmation
        alert (`Here is your current array of numbers to start Step #5:\n\n[ ${numArray} ]`)

        // function to process array for parts 5a, 5b, 5c
        // returns sum of elements from previous array which were greater than the numbers located after them in line.
        function processArray (localArr)
        {
            // if only a single value, return it as it is the answer to 5c.
            if (localArr.length == 1)   { return (localArr[0])  }

            tempArray = new Array()         // create an internal array to push to

            // starting with the second element in the passed array, compare it and previous element.
            for (let i = 1; i < localArr.length; ++i)
            {
                // if prior is bigger, push it onto internal array, otherwise ignore
                if (localArr[i-1] > localArr[i])    { tempArray.push(localArr[i-1])}
                // iterate to next value
            }
            // last element from passed array is always counted, therefore push it onto internal array.
            tempArray.push(localArr[localArr.length-1])

            // output confirmation
            alert (`Here is the resulting array from Step #5, part a and b :\n\n[ ${tempArray} ]`)

            // part 5c - adding the elements of the new array and returning the value

            let numSum = 0;         // initialize sum variable

            // iterate through new array, adding each value to the sum variable
            for (let j = 0; j<tempArray.length; ++j)    { numSum += tempArray[j] }
            
            // return sum
            return numSum;
        }

        /* Step #6 : Displays the total to the visitor with an alert. Concatenates the total at the end
        of this phrase: “The sum of the numbers is: <total>“ */
        let sumArray = processArray(numArray)
        alert (`Step #6: The sum of the numbers is: ${sumArray}.`)

        /* Step #7. Uses condiAonal logic (if/else):
            a. If the total is greater than 50:
            i. Alert: “That is a big number.”
            b. If the total is less than or equal to 50
            i. Alert: “That is a small number.” */

        // alert output using inline if/else to compare sum to 50 on the fly and edit output.
        alert (`Step #7: Sum = ${sumArray}.  That is a ${((sumArray > 50) ? 'big' : 'small')} number.`)

        /* Step #8. Uses a loop:
            a. Prompt and ask if the visitor wants to conAnue adding more numbers again,
            if yes (check for yes/no):
            i. Let the visitor provide a new set of numbers again and produce the
            result with an alert (steps 4-7 repeat) */

        // value assigned to result of ynValid function, serves as a check for yes, no, or invalid response.
        let tryAgain;    

        // handles robust prompt to repeat steps 4-7 or quit.
        do {
            // user prompt for yes or no
            let goAgain = prompt ("Step #8: Would you like to continue?  Enter 'yes' or 'no': ")

            // function to check for input validity
            function ynValid (localStr)
            {   
                let tempStr = localStr.toLowerCase()    // converts to lowercase to handle variants of yes and no

                if (tempStr === 'yes')          // if yes, return 1
                    return 1
                else if (tempStr === ('no'))    // if no, return 2
                    return 2
                else                            // if anything else (invalid), return 0
                    return 0;
            }
            
            tryAgain = ynValid(goAgain)         // store result in tryAgain

            switch (tryAgain)       // switch statement to set the proceed boolean for the master repeat loop
            {
                case 1:             // if 1, repeat steps 4-7
                    proceed = true;
                    break;
                case 2:             // if 2, end program
                    proceed = false;
                    break;
            }
        }
        while (!tryAgain);          // looks for if tryAgain is falsy (0 value - means invalid entry)
    }
    while (proceed);        // when proceed = false, end program
    // closing comment
    alert ('JavaScript complete : Have a nice day!')
}