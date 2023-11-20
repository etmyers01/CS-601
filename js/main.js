/*  main.css
    CS 601, Term Project
    Ed Myers
*/

// quick access function to change header content across pages.
function getHeader() {
    return `
    
    <header> <!-- main navigation -->
        <div id="nav-header">
            <h1>The Good Things</h1>
            <nav class="main-nav">
                <a id="current-page" class="active-page" href="./index.html">Home</a>
                <a href="./about.html">About Me</a>
                <a href="./location.html">My Backyard</a>
                <a href="./studies.html">Studies</a>
                <a href="./gallery.html">Gallery</a>
                <a href="./contact.html">Contact Me</a>
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