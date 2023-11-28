/*  main.css
    CS 601, Term Project
    Ed Myers
*/

// startup parameter to set functions that fire on page load
window.onload = startUp;       

function startUp() {
    setActivePage();        // sets menu button active page highlight on navigation menu
    highLighter();          // creates cell highlighting on individual table cells
}

// acquire page elements for manipulation
const currPage = document.getElementsByTagName('title');        // title tag
const anchorList = document.getElementsByTagName('a');          // anchor tags
const tableStyle = document.getElementsByTagName('td');         // all table data cells

// highlight function for table cells
function highLighter() {

    // for all table cells
    for (let c = 0; c < tableStyle.length; ++c) {                   
        tableStyle[c].onmouseover = function () {               // listen for mouseover event
            this.style.backgroundColor = 'yellow';                  // set cell background to yellow
        }
        tableStyle[c].onmouseleave = function () {              // listen for mouseleave event
            this.style.backgroundColor = 'rgb(177, 165, 143)';      // set cell background back to previous color
        }
    }
}

// active page navigation button highlight function
function setActivePage() {

    // for all anchor tags
    for (let i = 0; i < anchorList.length; ++i) {
        if (anchorList[i].id == currPage[0].id) {                   // if anchor ID = title ID (proof that button represents current page)
            anchorList[i].setAttribute('className', 'active-page'); // set className parameter equal to 'active-page' (triggers CSS styling)
            anchorList[i].setAttribute('id', 'current-page');       // set id parameter to 'current-page' (triggers CSS styling)
        }
    }
}

// quick access function to change header content across pages.
function getHeader() {
    return `
    
    <header> <!-- main navigation -->
        <div id="nav-header">
            <h1>The Good Things</h1>
            <nav class="main-nav">
                <a id='home' href="./index.html">Home</a>
                <a id='about' href="./about.html">About Me</a>
                <a id='location' href="./location.html">My Backyard</a>
                <a id='studies' href="./studies.html">Studies</a>
                <a id='gallery' href="./gallery.html">Gallery</a>
                <a id='contact' href="./contact.html">Contact Me</a>
            </nav>
        </div>
    </header> <!-- end main navigation -->

    `
}

// quick access function to change footer content across pages.
function getFooter() {
    return `
    <footer>
        <div class="footer">
            <p>&copy; 2023 Ed Myers - Created using Visual Studio Code - MIT License</p>
        </div>
    </footer>
    `
}