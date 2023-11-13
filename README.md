## CS-601 - Edward Myers <br> Web Application Design

### Programs Used:
-   Visual Studio Code - MIT License

### Instructions:
-   All files must stay together in the file directory found in the CS601_HW2_Myers.zip file.  The primary launch page is intended to be index.html

## New Version - Assignment #2 (CSS) 11/13/2023
Without using JavaScript, add CSS to your minimum 3-page HTML website and use the same file to style all pages through external link.  

### Features:
-   "main.css" is now used to externally style all web pages
-   All pages have been passed through W3C and CSS validation without errors
-   All major HTML tags and features have received some form of styling.
-   Page body behavior dynamically changes upon window resizing at three breakpoints using @media display tags (768px, 600px, and 400px)

### Above & Beyond
-   Multiple types of fonts were used across headers and paragraphs to give visual interest.
    -   A custom font ('satisfy') was taken from 1001fonts with free license and run through a font format generator at fontsquirrel.com.  The fonts are imported upon page load to style the section and table headers.  Several san-serif fonts are supplied as a failback.
-   The page body and all sub-content are set to max 960px for full width viewing.  The page uses table display with auto margins to achieve a constantly centered look despite the window width.
-   @keyframe amnimations were used to simulate slide in left and right effects for h2 and h3 headers.
-   Top navigation and header is positioned as fixed with use of z-index to create a static menu when scrolling.
-   Menu buttons are dynamically positioned, moving from flex inline to block grid to flex column as the viewable area contracts.
-   Menu buttons also have highlight styling on active page and on hover using pseudo class keys.  
-   Main page title uses a flexible width between certain breakpoints by using a calculation of minimum 12pt font while adding a view width multiplier for scaling.
-   Gallery page uses flexbox to reorganize pictures in a self-sorted double column.  This collapses to a single column upon screen shrink.
-   At screen breakpoints, numerous page attributes are affected:
    -   font size increases 
    -   images remove margins, auto-size down to 360px minimum
    -   headers become centered instead of left-justified
-   For print mode: several display changes are made:
    -   fonts converted to serif
    -   header and footer removed to move article content upward
    -   picture size is reduced to 500px to be less dominant on page
    -   article content is maximized to 100% of the page
    -   print margins are created at 2cm on all sides
    -   full link text is inserted after href links within content
    -   gallery imagery is forced to flex column mode to avoid column collision.


## Older Version - Assignment #1 (HTML) 11/6/2023
Generate an 3-page minimum HTML website that uses only HTML/HTML5 with no elements of CSS or JavaScript

### Features:
-   Each page has the miminum requirement as outlined in the Assignment #1 document.  All pages have been passed through the W3C validation check and have passed with no errors or comments.

### Above & Beyond
-   The submission included six pages
-   The audio file within index.html contains two types of audio files, enhancing compatibility
-   The submission uses multiple tables, lists and external links across numerous pages
-   In location.html, I nest an iframe of embedded google map code within a feature tag
-   Also within locastion.html are several inline operators and emoji demonstration
-   The contact.html page has several more external links as well as an email link.

Thank you for your time, I hope you enjoy my submission.
