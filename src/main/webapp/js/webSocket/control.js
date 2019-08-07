'use strict';

var selectZonePage = document.querySelector('#zoneSelection');
var connectedZonePage = document.querySelector('#zoneConnected');
var connectedZoneText = document.getElementById('connectedZoneText');
var beforeStart = document.querySelector('#beforeStart');
var sessionStartTimer = document.querySelector('#sessionStartTimer');
var exercisePlayer = document.querySelector('#exercisePlayer');

var stompClient = null;
var zone = null;

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
            showSessionTimerAndStartSession();
            // alert("Session Started");
        }
        else if(message.command == 'pause'){

        }
        else if(message.command == 'stop'){

        }
    }

//    showZoneConnected
    function showZoneConnected(){
        selectZonePage.classList.add('hidden');
        connectedZonePage.classList.remove('hidden');
        connectedZoneText.innerHTML = zone;
    }

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

//Event Listeners
selectZonePage.addEventListener('click' , connect , true)