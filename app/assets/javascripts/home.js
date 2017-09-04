$(document).ready(function() {
    // Get the modal
    var modal = document.getElementById('myModal');

// Get the button that opens the modal
    var btn1 = document.getElementById("signin");
    // var btn2 = document.getElementById("signup");

// Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

// When the user clicks on the button, open the modal
    btn1.onclick = function() {
        modal.style.display = "block";
    }

    // btn2.onclick = function() {
    //     modal.style.display = "block";
    // }

// When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }

// When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    var textarea = document.getElementById('question_content');

    console.log(textarea);


    var char = document.getElementById('characters');
    var create_question_submit = document.getElementById('create_question_submit');
    console.log(char);



    textarea.addEventListener('input', function() {
        console.log(textarea.value.length);


        char.innerHTML = textarea.value.length;

        if (textarea.value.length > 140) {
            char.style.color = "red";
            create_question_submit.disabled = true;


        } else {
            char.style.color = "black";
            create_question_submit.disabled = false;

        }
    });


    window.load_more_active = false;
    window.offset = 10;
    document.addEventListener('scroll', function(event){

        if(!window.load_more_active){
            if(window.scrollMaxY - event.pageY < 50){
                window.load_more_active = true;
                $.ajax({
                    url: '/',
                    type: 'GET',
                    dataType: 'script',
                    data: {
                        offset: window.offset,
                        format: 'js'
                    }
                });
            }
        }

    });

});


