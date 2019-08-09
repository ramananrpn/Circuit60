'use strict';

var selectZonePage = document.querySelector('#zoneSelection');
var connectedZonePage = document.querySelector('#zoneConnected');
var connectedZoneText = document.getElementById('connectedZoneText');
var beforeStart = document.querySelector('#beforeStart');
var sessionStartTimer = document.querySelector('#sessionStartTimer');
var exercisePlayer = document.querySelector('#exerciseDisplayScreen');
var error = document.querySelector('#error');

var stompClient = null;
var zone = null;
var loaded=0;
//connect function
    function connect(event) {
        // alert("yes");
        zone = event.target.id;
        if(zone){
            console.log("Selected Zone = " + zone) ;
            if(isStarted=='true') {
                showSessionTimerAndStartSession();
            }
            else{
                showZoneConnected();
            }
            var socket = new SockJS('/connectToAdmin');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, connectionSuccess);
        }
    }

//    connectSuccess Function
    function connectionSuccess() {
        stompClient.subscribe('/zone/client', onMessageReceived);
        stompClient.send("/admin/newZoneClient", {}, JSON.stringify({
            zone : zone,
            command : 'newZoneClient'
        }))
    }

//    Message Receive Function
    function onMessageReceived(payload) {
        var message = JSON.parse(payload.body);
        if(message.command == 'newZoneClient'){
            console.log("New User connected to the  - " + message.zone);
        }
        else if(message.command == 'start'){
            console.log("Template Started :: "+message.templateId);
            setExerciseOnDisplay(message.templateId,zone);
            if(loaded==1){
                showSessionTimerAndStartSession();
            }
            // alert("Session Started");
        }
        else if(message.command == 'pause'){

        }
        else if(message.command == 'stop'){

        }
        else if(message.command == 'display'){
            console.log(message.exerciseDetails[0].exerciseName);
        }
    }

//    Exercise for Template Fetch AJAX

    function setExerciseOnDisplay(templateId , zone){
        console.log("....AJAX FUNCTION CALLED... zone - " +zone + " ; TemplateId - " + templateId);
        // $.ajax({
        //     type : "POST" ,
        //     url : "/fetchExerciseDetailsToDisplay" ,
        //     data : {
        //         zone : zone,
        //         templateId : templateId
        //     },
        //     success : function (exercise){
        //         alert(exercise);
        //     },
        //     error : function () {
        //         showOnError();
        //         console.log("ERROR OCCURRED");
        //     }
        //
        // })
        stompClient.send("/admin/fetchExerciseDetails" , {} , JSON.stringify({
            zone : zone,
            templateId : templateId
        }))
    }

//    showZoneConnected
    function showZoneConnected(){
        selectZonePage.classList.add('hidden');
        connectedZonePage.classList.remove('hidden');
        connectedZoneText.innerHTML = zone;
    }

    //Show session Timer

    function showSessionTimerAndStartSession(){
        beforeStart.classList.add('hidden');
        sessionStartTimer.classList.remove('hidden');
        startSessionTimer(sessionStartTimer, exercisePlayer);
        console.log("Session Started");
    }

// Time Spinner
function startSessionTimer(sessionStartTimer , exercisePlayer) {
    var time = 0;
    var i = 10;
    var interval = setInterval(function () {
        $("#sectionStartTimerSeconds").text(i);
        if (i == time) {
            clearInterval(interval);
            sessionStartTimer.classList.add('hidden');
            exercisePlayer.classList.remove('hidden');
            return;
        }
        i--;
    }, 1000)
}

//ERROR
    function showOnError(){
        beforeStart.classList.add('hidden');
        error.classList.remove('hidden');
    }

//Event Listeners
selectZonePage.addEventListener('click' , connect , true)