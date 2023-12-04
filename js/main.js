/*  main.css
    CS 601, Term Project
    Ed Myers
*/

// startup parameter to set functions that fire on page load
window.onload = startUp;       

function startUp() {
    
    setActivePage();        // sets menu button active page highlight on navigation menu
    highLighter();          // creates cell highlighting on individual table cells
    setPalette();
}

// acquire page elements for manipulation
const currPage = document.getElementsByTagName('title');        // title tag (only one at currPage[0])
const anchorList = document.getElementsByTagName('a');          // anchor tags
const tableStyle = document.getElementsByTagName('td');         // all table data cells


function setPalette() {

    const head = document.getElementsByTagName('head')[0];  // get html head content
    const link = document.createElement('link');            // create a new link

    // set link attributes
    // credit : https://www.w3schools.com/lib/w3-theme-light-blue.css
    link.rel = 'stylesheet';
    link.type = 'text/css';
    link.href = './css/w3-theme-light-blue.css'; 

    // add new link back into 'head' (higher specificity)
    head.appendChild(link);

    // set body background color = light 4 theme
    document.getElementsByTagName('body')[0].setAttribute('class', 'w3-theme-l4');
    // set table background color = dark 1 theme
    document.getElementsByTagName('table')[0].setAttribute('class', 'w3-theme-d1');
  
    // set all table data cell backgrounds to light 2 theme
    for (const element of document.getElementsByTagName('td'))    {
        element.setAttribute('class', 'w3-theme-l2');
    }

    // set all table header backgrounds to light 1 theme
    for (const element of document.getElementsByTagName('th'))    {
        element.setAttribute('class', 'w3-theme-l1');
    }

    // set all h3 title tag backgrounds to light 2 theme
    for (const element of document.getElementsByTagName('h3'))    {
        element.setAttribute('class', 'w3-theme-l2');
    }
}

// highlight function for table cells
function highLighter() {

    // for all table cells
    for ( const element of tableStyle ) {
        element.onmouseover = function () {                     // listen for mouseover event
            element.setAttribute('class', 'w3-theme-d4');      // set cell background dark, text light
        }
        element.onmouseleave = function () {                    // listen for mouseleave event
            element.setAttribute('class', 'w3-theme-l2');      // set cell background light, text dark
        }
    }
}

// active page navigation button highlight function
function setActivePage() {

    // for all anchor tags
    for (const element of anchorList ) {
        if (element.id == currPage[0].id) {                   // if anchor ID = title ID (proof that button represents current page)
            element.setAttribute('class', 'w3-theme-dark');   // set className equal to 'w3 dark theme'
            element.setAttribute('id', 'current-page');       // set id parameter to 'current-page' (triggers further CSS styling)
        }
    }
}

// performs the fetch operation to acquire the JSON file
async function getProjects() {
    
    try {
        const res = await fetch("https://etmyers01.github.io/CS-601/json/projects.json");      // fetch attempted
        const data = await res.json();                                                     // data promise
        jsonParse(data);
    }
    catch(err) {                             // catch error
            alert(err);
    };
}

// JSON object parser
function jsonParse(localData) {

    // builds output html for the projects section dynamically based on JSON project file
    let outputHTML = '<h3 class="w3-theme-l2" >Code Examples and Papers</h3>';           // section header

    for (let i = 0; i < localData.projects.length; ++i) {           // for all projects existing from json object array
        
        const proj = localData.projects[i];                         // create reference project variable for current project index
        outputHTML +=                                               // add following output to html
        `
        <form action="${proj.url}">                                 <!-- form created, onsubmit= project url -->
        <fieldset class='w3-theme-l3'>                                                  <!-- fieldset begun -->
            <legend id="p_title">${proj.title}</legend>                 <!-- fieldset legend = project title -->
            <div id="p_type">Project Type: ${proj.code_type}</div>      <!-- div type = project code type -->
            <section id="p_body">                                       <!-- body section begun, holds description div and url submit button -->

                <div id="p_desc" class='w3-theme-l1'><strong>Description</strong>: ${proj.description}</div>    <!-- project description  -->
                <input type="submit" value="Click to see the project!" id="p_url">          <!-- url submit button -->
                
            </section>                                                  <!-- section end -->
            <div id="p_date">Date: ${proj.date}</div>                   <!-- div date = project date -->
            
        </fieldset>                                                 <!-- fieldset end -->
        </form>                                                     <!-- form end -->
        `;
    }

    document.getElementById("fromJSON").innerHTML = outputHTML;     // write html string to project section using .innerHTML() 
}

// quick access function to change header content across pages.
function getHeader() {
    return `
    
    <header> <!-- main navigation -->
        <div id="nav-header">
            <h1>The Good Things</h1>
            <nav class="main-nav">
                <a id='home' class='w3-theme-l1' href="./index.html">Home</a>
                <a id='about' class='w3-theme-l1' href="./about.html">About Me</a>
                <a id='location' class='w3-theme-l1' href="./location.html">My Backyard</a>
                <a id='studies' class='w3-theme-l1' href="./studies.html">Studies</a>
                <a id='projects' class='w3-theme-l1' href="./projects.html">Projects</a>
                <a id='gallery' class='w3-theme-l1' href="./gallery.html">Gallery</a>
                <a id='null'></a>   <!-- placeholder for grid to center contact button -->
                <a id='contact' class='w3-theme-l1' href="./contact.html">Contact Me</a>
                <a id='null'></a>   <!-- placeholder for grid to center contact button --> 
            </nav>
        </div>
    </header> <!-- end main navigation -->

    `
}

// quick access function to change footer content across pages.
function getFooter() {
    return `
    <footer>
        <div id="footer" class="footer w3_theme-d2">
            <p>&copy; 2023 Ed Myers - Created using Visual Studio Code - MIT License</p>
            <a target="_blank" href="https://icons8.com/icon/aHwWbh5ZWWLq/clover">Clover</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>
        </div>
    </footer>
    `
}