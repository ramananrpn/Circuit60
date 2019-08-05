'use strict';

var selectZonePage = document.querySelector('#zoneSelection');
var connectedZonePage = document.querySelector('#zoneConnected');
var connectedZoneText = document.getElementById('connectedZoneText');
var beforeStart = document.querySelector('#beforeStart');
var sessionStartTimer = document.querySelector('#sessionStartTimer');

var stompClient = null;
var zone = null;

//connect function
    function connect(event) {
        // alert("yes");
        zone = event.target.id;
        if(zone){
            console.log("Selected Zone = " + zone) ;

            selectZonePage.classList.add('hidden');
            connectedZonePage.classList.remove('hidden');
            connectedZoneText.innerHTML = zone;
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
        }else if(message.command == 'start'){
            console.log("Session Started");
            alert("Session Started");
            beforeStart.classList.add('hidden');
            sessionStartTimer.classList.remove('hidden');
        }
    }

//Event Listeners
selectZonePage.addEventListener('click' , connect , true)