/* Ed Myers
CS 601 - Term Project
vue-code.js */

// Vue app creation - header navigation menu insert
const header_app = Vue.createApp({

    // data function returning variables for use within the template
    data() {
        return {
            // array of button objects (id, class, href & text)
            buttons: [
                { id: 'home', class: 'w3-theme-l1', href: "./index.html", text: 'Home' },
                { id: 'about', class: 'w3-theme-l1', href: "./about.html", text: 'About Me' },
                { id: 'location', class: 'w3-theme-l1', href: "./location.html", text: 'My Backyard' },
                { id: 'studies', class: 'w3-theme-l1', href: "./studies.html", text: 'Studies' },
                { id: 'projects', class: 'w3-theme-l1', href: "./projects.html", text: 'Projects' },
                { id: 'gallery', class: 'w3-theme-l1', href: "./gallery.html", text: 'Gallery' },
                { id: 'null', class: '', href: "", text: '' },
                { id: 'contact', class: 'w3-theme-l1', href: "./contact.html", text: 'Contact Me' },
                { id: 'null', class: '', href: "", text: '' }
            ],
            // class tracker for mobile menu open/closed status
            mobile_menu_class: 'closed'
        }
    },

    // methods declarations
    methods:
    {
        // the main navigation header has a class value of open or closed to determine mobile menu visibility
        // if button is clicked and menu is 'closed', class is changed to 'open' and CSS makes menu appear
        toggleMenu() {
            (this.mobile_menu_class == 'closed') ? this.mobile_menu_class = 'open' : this.mobile_menu_class = 'closed';
        }
    },

    // template HTML that contains VUE syntax
    template:
        ` 
        <div :id="'nav-header'" :class="mobile_menu_class">

            <!-- mobile button and h1 header container -->
            <div :id="'hdrCont'">
                <button @click="toggleMenu()" :id="'smallMenu'" :value="''" ></button>
                <h1>The Good Things</h1>
            </div>

            <!-- main navigation container -->
            <!-- for as many buttons as are in the buttons array, dynamically create them! -->
            <nav :class="'main-nav'" :id="'main-nav'" >
                <a v-for="button in buttons"
                    :id='button.id'
                    :class='button.class'
                    :href='button.href'
                > {{button.text}} </a>
            </nav>
        </div>
    `
}).mount("#header_app")


// Vue app creation - footer insert
const footer_app = Vue.createApp({

    // data function returning variables for use within the template
    data() {
        return {
            // clover favicon link
            clover_href: "https://icons8.com/icon/aHwWbh5ZWWLq/clover",
            icon_href: "https://icons8.com"
        }
    },

    // template HTML that contains VUE syntax
    template:
        `
        <div :id="'footer'" :class="'footer w3_theme-d2'">
            <p>&copy; 2023 Ed Myers - Created using Visual Studio Code - MIT License</p>
            <a :target="'_blank'" :href='clover_href'>Clover</a> icon by <a :target="'_blank'" :href="icon_href">Icons8</a>
        </div>
    `
}).mount("#footer_app")
