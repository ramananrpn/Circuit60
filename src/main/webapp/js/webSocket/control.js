'use strict';

var selectZonePage = document.querySelector('#zoneSelection');
var connectedZonePage = document.querySelector('#zoneConnected');
var connectedZoneText = document.getElementById('connectedZoneText');
var beforeStart = document.querySelector('#beforeStart');
var sessionStartTimer = document.querySelector('#sessionStartTimer');
var exercisePlayer = document.querySelector('#exerciseDisplayScreen');
var error = document.querySelector('#error');
var repsIteratorScreen = document.querySelector('#repsIteratorScreen');
var breakTimer = document.querySelector('#breakTimer');
var repsIteratorText = document.getElementById('repsIteratorText');
//repsCount in Session Screen
var displayRepsCount = document.getElementById('displayRepsCount');
//Exercise Timer
var displayExerciseSecondsTimer = document.getElementById('displayExerciseSecondsTimer');
//switch screen
var switchScreen = document.querySelector('#switchScreen');
var isSwitchScreen = 0;

var stompClient = null;
var timestamp;
var jsZone = null;
var jsTemplateId= null;
var loaded=0;
var exerciseTimer;
var exerciseSeconds;
var repsCount;
var totalReps;
var breakSeconds;
var totalExercise;
var exerciseCount;

// Screen Delay Time Config Constants
var switchScreenDelay = 5000;  // in milliseconds

var sessionStartTimerDelay = 10;  // in seconds


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
        var d = new Date();
        timestamp = d.getTime();
        stompClient.subscribe('/zone/client.'+selectedZone+'.'+timestamp, onMessageReceived);
        stompClient.send("/admin/newZoneClient."+selectedZone+'.'+timestamp, {}, JSON.stringify({
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
            jsTemplateId = message.templateId;
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
            //TemplateName
            var displayTemplateName = document.getElementById('displayTemplateName');
            var repsTemplateNameText = document.getElementById('repsTemplateNameText');
            repsCount = totalReps = message.zones.reps;
            //exercise count
            totalExercise = exerciseCount = message.exerciseDetails.length;
            exerciseSeconds = (message.zones.seconds);

            //Current Zone
            var displayZone = document.getElementById('displayZone');
            var repsZoneText = document.getElementById('repsZoneText');

            //water Break
            breakSeconds = message.zones.breakTime;
            try{
                    //Assign Template Name
                    displayTemplateName.innerHTML = repsTemplateNameText.innerHTML = message.zones.templateId.templateName;
                    //Assign reps count
                    displayRepsCount.innerHTML = repsCount;
                    repsIteratorText.innerHTML =1;
                    //Assign Exercise Seconds in timer
                    displayExerciseSecondsTimer.innerHTML = exerciseSeconds;

                    //switch screen delay
                    // switchScreenDelay = message.templates.switchScreenDuration * 1000;
                    for(var i = 0; i< message.exerciseDetails.length ; i++){
                        //Exercise Player
                        // Assign exercise Name
                        var displayExerciseName = document.getElementById("displayExerciseName-"+i);
                        displayExerciseName.innerHTML = message.exerciseDetails[i].exerciseName;
                        displayExerciseName.classList.remove('hidden');

                        //Assign Video path in src of VIDEO tag
                        var mediaPath = message.exerciseDetails[i].url.substring(5,message.exerciseDetails[i].url.length);
                        console.log("URL - " + mediaPath);
                        var videoPlayer = document.getElementById("video-"+i);
                        videoPlayer.src=mediaPath;
                        videoPlayer.classList.remove('hidden');
                        videoPlayer.classList.add('running');

                        //assign zone String to display current zone
                        displayZone.innerHTML = repsZoneText.innerHTML = "ZONE 0" + message.zones.zone.match(/\d+/)[0];

                    }
                            //show DISPLAY SCREEN
                            showSessionTimerAndStartSession();

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
        stompClient.send("/admin/fetchExerciseDetails."+zone+'.'+timestamp , {} , JSON.stringify({
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
        startSessionTimer();
        console.log("Session Started");
    }

    //REPS ITERATION SCREEN AND START SESSION
    function showRepsCountAndStartSession() {
        repsIteratorText.innerHTML = (parseInt(repsIteratorText.innerHTML)+1) + " REPS";
        console.log("Reps Iterator Text : " + repsIteratorText.innerHTML);
        displayRepsCount.innerHTML = parseInt(displayRepsCount.innerHTML)-1;
        // breakTimer.classList.add('hidden');
        exercisePlayer.classList.add('hidden');
        repsIteratorScreen.classList.remove('hidden');
        setTimeout(function(){
            repsIteratorScreen.classList.add('hidden');
            exercisePlayer.classList.remove('hidden');
            loadVideoElements(exerciseSeconds);
        }, 5000);

    }

// Time Spinner
    //SESSION START TIMER
    function startSessionTimer() {
        document.getElementById("sectionStartTimerSeconds").innerHTML = sessionStartTimerDelay;
        var time = 0;
        var i = sessionStartTimerDelay;
        var startTimer = setInterval(function () {
            $("#sectionStartTimerSeconds").text(i);
            if (i == time) {
                clearInterval(startTimer);
                sessionStartTimer.classList.add('hidden');
                exercisePlayer.classList.remove('hidden');
                // var seconds = document.getElementById('displayExerciseSecondsTimer').innerHTML;
                playVideoElements(exerciseSeconds);
                return;
            }
            i--;
        }, 1000)
    }


    // WATER BREAK SCREEN and TIMER
    function showWaterBreakScreen(seconds) {
        exercisePlayer.classList.add('hidden');
        breakTimer.classList.remove('hidden');
        //BREAK TIMER
        var startTimer = setInterval(function () {
            $("#breakTimerSeconds").text(seconds);
            if (seconds == 0){
                clearInterval(startTimer);
                document.getElementById('breakTimerSeconds').innerHTML = breakSeconds;
                displayExerciseSecondsTimer.innerHTML = exerciseSeconds;
                repsIteratorText.innerHTML = 1;
                console.log("Reps Iterator Text : " + repsIteratorText.innerHTML);
                displayRepsCount.innerHTML = totalReps;
                exerciseCount = totalExercise;
                breakTimer.classList.add('hidden');
                sessionStartTimer.classList.remove('hidden');
                startSessionTimer();
                return;
            }
            seconds--;
        }, 1000)
    }

    //Exercise Timer
    //Start
    function startExerciseTimer(seconds , mode) {
         exerciseTimer = setInterval(function () {
            $("#displayExerciseSecondsTimer").text(seconds);
            if (seconds == 0 || mode!='start') {
                clearInterval(exerciseTimer);
                exerciseCount--;
                // exercise iteration - showing switch screen
                if(exerciseCount>0){
                    console.log("---SHOWING SWITCH SCREEN --");
                    exercisePlayer.classList.add('hidden');
                    switchScreen.classList.remove('hidden');
                    setTimeout(function(){
                        displayExerciseSecondsTimer.innerHTML = exerciseSeconds;
                        switchScreen.classList.add('hidden');
                        exercisePlayer.classList.remove('hidden');
                        loadVideoElements(exerciseSeconds);
                    }, switchScreenDelay);
                }
                // ALL Exercise Iterations completed - checking for reps iteration
                else{
                    repsCount--;
                    exerciseCount = totalExercise;
                    if(repsCount>=1) {
                        showRepsCountAndStartSession();
                    }
                    else{
                        document.getElementById('breakTimerSeconds').innerHTML = breakSeconds;
                        showWaterBreakScreen(breakSeconds);
                    }
                }
                // repsCount--;
                // if(repsCount>=1) {
                //     console.log("Reps Count in start exercise Timer : " + repsCount);
                //     displayExerciseSecondsTimer.innerHTML = exerciseTimer;
                //     document.getElementById('breakTimerSeconds').innerHTML = breakSeconds;
                //     showWaterBreakScreen(breakSeconds);
                // }
                // else {
                //     console.log("---SHOWING SWITCH SCREEN --");
                //     exercisePlayer.classList.add('hidden');
                //     switchScreen.classList.remove('hidden');
                //     repsIteratorText.innerHTML = 1;
                //     console.log("Reps Iterator Text : " + repsIteratorText.innerHTML);
                //     displayRepsCount.innerHTML = totalReps;
                //     setTimeout(function(){
                //         switchScreen.classList.add('hidden');
                //         exercisePlayer.classList.remove('hidden');
                //         loadVideoElements(exerciseSeconds);
                //     }, switchScreenDelay);
                // }
                return;
            }
            seconds--;
        }, 1000)
    }
    //pause
    function pauseExerciseTimer() {
        clearInterval(exerciseTimer);
    }

    //        ------------ VIDEO CONTROL --------------
    //Pause Play Video Elements
    //PLAY
    function playVideoElements(seconds) {
        var videoElements = document.querySelectorAll('.running');
        [].forEach.call(videoElements, function (vidElement) {
            vidElement.play();
        });
        startExerciseTimer(seconds , "start");
    }

    // LOAD
    function loadVideoElements(seconds) {
        var videoElements = document.querySelectorAll('.running');
        [].forEach.call(videoElements, function (vidElement) {
            vidElement.load();
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