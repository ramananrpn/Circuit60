'use strict';

var selectZonePage = document.querySelector('#zoneSelection');
var connectedZonePage = document.querySelector('#zoneConnected');
var connectedZoneText = document.getElementById('connectedZoneText');
var beforeStart = document.querySelector('#beforeStart');
var sessionStartTimer = document.querySelector('#sessionStartTimer');
var exercisePlayer = document.querySelector('#exerciseDisplayScreen');
var error = document.querySelector('#error');

var stompClient = null;
var jsZone = null;
var loaded=0;
var exerciseTimer;

//connect function
    function connect(event) {
        // alert("yes");
        jsZone = event.target.id;
        if(jsZone){
            console.log("Selected Zone = " + jsZone) ;
            document.getElementById("currentZoneHidden").value = jsZone;
            if(isStarted!='true') {
                // setExerciseOnDisplay(activeTemplate,jsZone);
                showZoneConnected();
                // showSessionTimerAndStartSession();
            }
            var socket = new SockJS('/connectToAdmin');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, connectionSuccess);
        }
    }

//    connectSuccess Function
    function connectionSuccess() {
        var selectedZone = document.getElementById("currentZoneHidden").value;
        console.log("Selected Zone Hidden field = " + selectedZone) ;
        stompClient.subscribe('/zone/client.'+selectedZone, onMessageReceived);
        stompClient.send("/admin/newZoneClient."+selectedZone, {}, JSON.stringify({
            zone : jsZone,
            command : 'newZoneClient'
        }))
    }

//    Message Receive Function
    function onMessageReceived(payload) {
        var message = JSON.parse(payload.body);
        if(message.command == 'newZoneClient'){
            console.log("New User connected to the  - " + message.zone);
            if(isStarted=='true') {
                var selectedZone = document.getElementById("currentZoneHidden").value;
                console.log("Selected Zone Hidden field = " + selectedZone) ;
                setExerciseOnDisplay(activeTemplate,selectedZone);
            }
        }
        else if(message.command == 'start'){
            console.log("Template Started :: "+message.templateId);
            var selectedZone = document.getElementById("currentZoneHidden").value;
            console.log("Selected Zone Hidden field = " + selectedZone) ;
            setExerciseOnDisplay(message.templateId,selectedZone);

            // alert("Session Started");
        }
        else if(message.command == 'pause'){
            var seconds = document.getElementById('displayExerciseSecondsTimer').innerHTML;
            pauseVideoElements(seconds);
        }
        else if(message.command == 'stop'){
            isStarted=false;
            stompClient.disconnect();
            location.reload();
        }
        else if (message.command == 'resume'){
            var currentSeconds = document.getElementById('displayExerciseSecondsTimer').innerHTML;
            playVideoElements(currentSeconds);
        }
        else if(message.command == 'display'){
            console.log(message.exerciseDetails.length);
            console.log(message.zones.templateId.templateName);
            console.log(message.zones.reps);
            console.log(message.zones.seconds);
            var displayTemplateName = document.getElementById('displayTemplateName');
            var displayRepsCount = document.getElementById('displayRepsCount');
            var displayExerciseSecondsTimer = document.getElementById('displayExerciseSecondsTimer');
            var displayZone = document.getElementById('displayZone');
            var repsCount =  message.zones.reps;
            var exerciseCount = message.exerciseDetails.length;
            try{

                while(repsCount!=0){
                    displayTemplateName.innerHTML = message.zones.templateId.templateName;
                    displayRepsCount.innerHTML = repsCount;
                    displayExerciseSecondsTimer.innerHTML = (message.zones.seconds)*exerciseCount;
                    for(var i = 0; i< message.exerciseDetails.length ; i++){
                        var displayExerciseName = document.getElementById("displayExerciseName-"+i);
                        displayExerciseName.innerHTML = message.exerciseDetails[i].exerciseName;
                        displayExerciseName.classList.remove('hidden');
                        var mediaPath = message.exerciseDetails[i].url.substring(5,message.exerciseDetails[i].url.length);
                        console.log("URL - " + mediaPath);
                        var videoPlayer = document.getElementById("video-"+i);
                        videoPlayer.src=mediaPath;
                        videoPlayer.classList.remove('hidden');
                        videoPlayer.classList.add('running');
                        displayZone.innerHTML = "ZONE 0" + message.zones.zone.match(/\d+/)[0];

                    }
                        //show DISPLAY SCREEN
                        showSessionTimerAndStartSession();
                    repsCount--;
                }
            }catch (e) {
                console.log("Error Occured while Fetching exerciseDetails " + e);
                loaded= 0;
                showOnError();
            }
        }
        else if(message.command == 'empty'){
            showEmptyZone();
        }
    }

//    Exercise for Template Fetch AJAX

    function setExerciseOnDisplay(templateId , zone){
        console.log("....AJAX FUNCTION CALLED... zone - " +zone + " ; TemplateId - " + templateId);
        var selectedZone = document.getElementById("currentZoneHidden").value;
        console.log("Selected Zone Hidden field = " + selectedZone) ;
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
        stompClient.send("/admin/fetchExerciseDetails."+zone , {} , JSON.stringify({
            zone : zone,
            templateId : templateId
        }))
    }

//    showZoneConnected
    function showZoneConnected(){
        selectZonePage.classList.add('hidden');
        connectedZonePage.classList.remove('hidden');
        connectedZoneText.innerHTML = document.getElementById("currentZoneHidden").value;
    }

    //Show session Timer

    function showSessionTimerAndStartSession(){
        beforeStart.classList.add('hidden');
        sessionStartTimer.classList.remove('hidden');
        startSessionTimer(sessionStartTimer, exercisePlayer);
        console.log("Session Started");
    }

    function showRepsCountAndStartSession() {
        exercisePlayer.classList.add('hidden');

    }

// Time Spinner
function startSessionTimer(sessionStartTimer , exercisePlayer) {
    var time = 0;
    var i = 2;
    var startTimer = setInterval(function () {
        $("#sectionStartTimerSeconds").text(i);
        if (i == time) {
            clearInterval(startTimer);
            sessionStartTimer.classList.add('hidden');
            exercisePlayer.classList.remove('hidden');
            var seconds = document.getElementById('displayExerciseSecondsTimer').innerHTML;
            playVideoElements(seconds);
            return;
        }
        i--;
    }, 1000)
}

    //Exercise Timer
    //Start
    function startExerciseTimer(seconds , mode) {
         exerciseTimer = setInterval(function () {
            $("#displayExerciseSecondsTimer").text(seconds);
            if (seconds == 0 || mode!='start') {
                clearInterval(exerciseTimer);
                stompClient.disconnect();
                location.reload();
                return;
            }
            seconds--;
        }, 1000)
    }
    //pause
    function pauseExerciseTimer() {
        clearInterval(exerciseTimer);
    }

    //Pause Play Video Elements
    function playVideoElements(seconds) {
        var videoElements = document.querySelectorAll('.running');
        [].forEach.call(videoElements, function (vidElement) {
            vidElement.play();
        });
        startExerciseTimer(seconds , "start");
    }

    function pauseVideoElements(seconds) {
        var videoElements = document.querySelectorAll('.running');
        [].forEach.call(videoElements, function (vidElement) {
            vidElement.pause();
        });
         pauseExerciseTimer();
    }
//ERROR
    function showOnError(){
        beforeStart.classList.add('hidden');
        document.getElementById('displayErrorText').innerText = "Sorry , Error Occurred . Please try again. " ;
        error.classList.remove('hidden');
    }

//    Empty Zone
    function showEmptyZone(){
        beforeStart.classList.add('hidden');
        document.getElementById('displayErrorText').innerText = " No Exercise Found for Current Zone " ;
        error.classList.remove('hidden');
    }

//Event Listeners
selectZonePage.addEventListener('click' , connect , true)