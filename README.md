## CS-601 - Edward Myers <br> Web Application Design

### Programs Used:
-   Visual Studio Code - MIT License

### Instructions:
-   All files must stay together in the file directory found in the GitHub repository.  The primary launch page is intended to be index.html

## New Version - Term Project (HTML, CSS, JavaScript, Vue.js, etc.) 12/8/2023 Work in Progress
-   Students will be evaluated on how well they have mastered the following topics:
    -	Web languages 
    -	HTML5
    -	CSS 3
    -	JavaScript
    -	Vue
    -	Web page layout and design
    -	Document object model (DOM)
    -	Website usability
    -	Project management for web design and development
 
### Features:
-   Vue + JavaScript is now utilized to construct header and footer, which make alteration easier across multiple pages without editing HTML.
-   DOM Manipulation from JS.
    -   JavaScript is used to highlight navigation button corresponding to active page using tag ID comparisons.
    -   JavaScript is used to highlight table data cells in all table on mouseover.
    -   JS setPalette() function used to override color css.
-   Favicon installed in head of each page
-   W3C light blue palette .css file employed for continuity (credit: https://www.w3schools.com/lib/w3-theme-light-blue.css)
-   Multiple image resolutions supported based on viewing window via @media tag.  All original images upon load are individually sized, alt tagged and src set prior to CSS styling.
-   Website live on GitHub Pages (https://etmyers01.github.io/CS-601/)
-   Code public on GitHub repo (https://github.com/etmyers01/CS-601)
-   Elements tested on Windows 10, 11 browsers
    -   Microsoft Edge      (900+px, 600px, 400px sliding scale)
    -   Mozilla Firefox     (900+px, 600px, 400px sliding scale)
    -   Google Chrome       (900+px, 600px, 400px sliding scale)
-   Elements tested on Samsung Galaxy S21
    -   Google Chrome app   (400px mobile portrait rotation, 600px landscape rotation)
    -   Mozilla Firefox app (400px mobile portrait rotation, 600px landscape rotation)

### Reflections  
-   I put a significant amount of time into this website (40+ hours).  Most of the time was spent testing it across different browsers and resizing.  I found it challenging to get the required elements in at the end due to time constraints as I didn't have the luxury of tons of independent research time or forward reading through the modules as was suggested.  As a result I feel about 90% happy with the state of the site at this time.  Given longer, I would incorporate more JS and Vue.js elements to add more functionality and probably rework some of the flow between different breakpoint views.  
-   I took into consideration the recommendations of my mid-term project review and incorporated many of the features suggested, such as a reworked menu in mobile-mode, favicons, noscript tags, adjusting the usage of script font, edge bordering, more JavaScript functionality and Vue.js components. Testing was as robust as I could make it with the devices I had available.  

Thank you for your time, I hope you enjoy my submission.

### Above & Beyond (across versions)
-   JSON & JavaScript w/ fetch is used to dynamically populate work examples to DOM within projects page.
-   Contacts page has clickable buttons that generate dynamic HTML content, then uses keyframe animations to fade in and out before resetting the HTML.
-   Mobile hamburger button created for viewing on mobile devices to enable and collapse main navigation
-   Quote API utilized to create random quote on the contacts page.
    - credit : https://forum.freecodecamp.org/t/free-api-inspirational-quotes-json-with-code-examples/311373
-   limited functionality exists for viewing with script blockers using noscript tags.

#### From Version 2
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
    -   images remove margins, auto-size down to 400px minimum
    -   headers become centered instead of left-justified
-   For print mode: several display changes are made:
    -   fonts converted to serif
    -   header and footer removed to move article content upward
    -   picture size is reduced to 500px to be less dominant on page
    -   article content is maximized to 100% of the page
    -   print margins are created at 2cm on all sides
    -   full link text is inserted after href links within content
    -   gallery imagery is forced to flex column mode to avoid column collision.

#### From Version 1
-   The submission included six pages
-   The audio file within index.html contains two types of audio files, enhancing compatibility
-   The submission uses multiple tables, lists and external links across numerous pages
-   In location.html, I nest an iframe of embedded google map code within a feature tag
-   Also within location.html are several inline operators and emoji demonstration
-   The contact.html page has several more external links as well as an email link.

## Old Version #2 - Assignment #2 (CSS) 11/13/2023
Without using JavaScript, add CSS to your minimum 3-page HTML website and use the same file to style all pages through external link.  

### Features:
-   "main.css" is now used to externally style all web pages
-   All pages have been passed through W3C and CSS validation without errors
-   All major HTML tags and features have received some form of styling.
-   Page body behavior dynamically changes upon window resizing at three breakpoints using @media display tags (900px, 600px, and 400px)

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


## Old Version #1 - Assignment #1 (HTML) 11/6/2023
Generate an 3-page minimum HTML website that uses only HTML/HTML5 with no elements of CSS or JavaScript

### Features:
-   Each page has the miminum requirement as outlined in the Assignment #1 document.  All pages have been passed through the W3C validation check and have passed with no errors or comments.

### Above & Beyond
-   The submission included six pages
-   The audio file within index.html contains two types of audio files, enhancing compatibility
-   The submission uses multiple tables, lists and external links across numerous pages
-   In location.html, I nest an iframe of embedded google map code within a feature tag
-   Also within location.html are several inline operators and emoji demonstration
-   The contact.html page has several more external links as well as an email link.