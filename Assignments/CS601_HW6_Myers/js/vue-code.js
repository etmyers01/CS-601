/* Ed Myers
CS 601 - Assignment 6
vue-code.js */

// Vue app creation
const app = Vue.createApp({

    // data function returning variables for use within the template
    data() {
        return {
            // array of animal objects (name, old picture, young picture, and hover status)
            animals: [
                { name: 'cat', old: 'cat_old.jpg', young: 'cat_young.jpg', hover: false },
                { name: 'dog', old: 'dog_old.jpg', young: 'dog_young.jpg', hover: false },
                { name: 'gorilla', old: 'gorilla_old.jpg', young: 'gorilla_young.jpg', hover: false },
                { name: 'elephant', old: 'elephant_old.jpg', young: 'elephant_young.jpg', hover: false },
            ],
            // form display string text
            form_text: 'Try clicking on a picture after you hover...',
            // active picture display text
            last_active:'',
            // click counter tracker
            click_count: 0,
            // hover counter tracker
            hover_count: 0
        }
    },

    // methods declarations
    methods:
    {
        // selects active picture based on hover status
        pictureSelect(localIndex) {                         // for a specific animal (animals[localIndex])
            if (!this.animals[localIndex].hover)                // if mouse is not hovering
                return this.animals[localIndex].old;        // active picture is the old one
            else                                                // if mouse is hovering
                return this.animals[localIndex].young;      // active picture is the young one
        },
        // returns hover status based on index passed
        isHover(localIndex) {
            return this.animals[localIndex].hover;
        },
        // adds passed in text to the textarea
        addText(newText) {
            this.form_text += '\n  - ' + newText;
        },
        // clears textarea and sets clear message.  
        clearText() {
            this.form_text = 'Clear was pressed.  Try clicking pictures again...';
            this.last_active = '';                          // resets legend message
            ++this.click_count;                             // increments click counter
        },
        // sets legend message with last picture interacted with
        legendText() {
            if (this.last_active == '')                     // if no animals active, reset message
                return "Interacting with Vue".toUpperCase();
            else                                            // else augment message with active animal
                return ("You last clicked on : " + this.last_active + '!').toUpperCase();
        }
    },

    // template HTML that contains VUE syntax
    template:
        `
        <div :id="'form_box'">
            <!-- begin form -->
            <form>
                <!-- button container -->
                <div :id="'container'"> 
                    <!-- clear input button -->
                    <p>
                        <input type='button'
                        @click=clearText() 
                        :value="'Clear Results'">
                    </p>

                    <!-- click counter -->
                    <p :id="'clickCounter'">
                        How many clicks have you made today?: {{click_count}}
                    </p>

                    <!-- hover counter -->
                    <p :id="'hoverCounter'">
                        How many hovers over pictures did you make today? : {{hover_count}}
                    </p>

                </div>

                <!-- text area within fieldset -->
                <fieldset>
                    <!-- invokes legendText function for legend -->
                    <legend>
                        {{ legendText() }}
                    </legend>
                    
                    <textarea :id="'textArea'" :name="'textArea'" :rows="10"  readonly>{{form_text}}
                    </textarea>
                </fieldset>
                
                <!-- conditional text to be shown after 10 interactions -->
                <p :id="'flyText'" v-if="( (click_count + hover_count) >= 10)" >Congratulations! You were interactive 10 times today!!!</p>
                
            </form>
            <!-- end form -->
        </div>

        <div :id="'img_box2'">

            <!-- index iterator for 4 pictures -->
            <figure v-for="index in [0,1,2,3]">
                
                <!-- load 4 pictures 
                    - invoke pictureSelect to get source
                    - set width/height
                    - mouseover and mouseout change hover status of current indexed picture
                    - inline if which changes the alt text based on hover status and picture type
                    - clicking invokes the addText function to add to textarea, changes legend and increments click counter
                -->    

                <img  
                    :src="'./images/' + pictureSelect(index)"

                    @mouseover="animals[index].hover=true, ++hover_count"
                    @mouseout="animals[index].hover=false"

                    width = "640" height = "480"
                
                    :alt="'A picture of ' + (isHover(index) ? 'a young ' : 'an old ') + animals[index].name"

                    @click="addText('you clicked on : ' + animals[index].name), last_active = animals[index].name, ++click_count"
                >

                <!-- figcaption changes based on hover status and picture type -->
                <figcaption>
                    You are looking at {{ (isHover(index)) ? "a young " : "an old " }} {{animals[index].name.toUpperCase()}}.
                </figcaption> 

            </figure>

        </div>

    `
}).mount("#app")
