<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Circuit |Welcome|</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="css/mdb.min.css" rel="stylesheet">
    <!--  custom styles  -->
    <link href="css/style.css" rel="stylesheet">
    <link href="css/circle.css" rel="stylesheet">
</head>
<style>
    html,
    body,
    header,
    .view {
        height: 100%;
    }
    .rgba-gradient {
        opacity: 0.85;
        -webkit-backdrop-filter: blur(5.8px);
        backdrop-filter: blur(5.8px);
        background-image: linear-gradient(119deg, #5266ff, #c9138a);
    }
    .next{
        width: 25px;
        height: 35px;
        object-fit: contain;
    }
    svg {
        -webkit-transform: rotate(-90deg);
        transform: rotate(-90deg);
    }

    .circle_animation {
        stroke-dasharray: 440; /* this value is the pixel circumference of the circle */
        stroke-dashoffset: 440;
        transition: all 1s linear;
    }
    
    .circle {
	width: 200px;
    margin: 6px 20px 20px;
    display: inline-block;
    position: relative;
    text-align: center;
	vertical-align: top;
	strong {
		position: absolute;
		top: 70px;
		left: 0;
		width: 100%;
		text-align: center;
		line-height: 45px;
		font-size: 43px;
	}
}
</style>

<%--set isStarted var globally--%>
<script>
    var isStarted = "<c:out value="${isTemplateActive}"></c:out>"
    if(isStarted=='true'){
        var activeTemplate = "<c:out value="${activeTemplate.getTemplateId()}"></c:out>";
    }
</script>
<body class="overflow-hidden">

<input type="hidden" id="currentZoneHidden">
<%-- Before Start Screen --%>
    <div class="view " style="background-image: url('../../img/action-athlete-barbell-841130.png'); background-repeat: no-repeat; background-size: cover; background-position: center center;" id="beforeStart">
        <div class="mask rgba-gradient align-items-center " >
            <div class="container flex-center">
                <div class="white-text text-center">
                    <%--       zones selection      --%>
                    <div class="btn-group-vertical" role="group" aria-label="Vertical button group" id="zoneSelection">
                        <a type="button" class="btn btn-amber " id="zone1" >zone 01</a>
                        <a type="button" class="btn btn-amber " id="zone2" >zone 02</a>
                        <a type="button" class="btn btn-amber " id="zone3" >zone 03</a>
                        <a type="button" class="btn btn-amber " id="zone4" >zone 04</a>
                        <a type="button" class="btn btn-amber " id="zone5" >zone 05</a>
                        <a type="button" class="btn btn-amber " id="zone6" >zone 06</a>
                    </div>
                    <%--       Zone Connection         --%>
                    <div id="zoneConnected" class="hidden">
                    <span>
                        <img src="img/Logo.png" class="img-fluid">
                    </span>
                        <span class="row white-text text-center flex-center mt-5">
                        <h5>Connected to </h5>&nbsp;
                        <b><h5 id="connectedZoneText"></h5></b>
                    </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

                            <%---------------------      SESSION START TIMER        ---------------------------%>

<%--After Start Screen - SESSION START TIMER --%>
<div class="flex-center hidden" id="sessionStartTimer" style="height: 100vh;width: 100%">
    <div class="text-center" >
        <h2>The Session will start in </h2>
         <div class="flex-center container img-fluid">
         <img src="/img/sessionStartBg.svg">
           <div class="c100 big" id="secondsTimerPercentage" style="position:absolute">
  			<span class="flex-center " id="sectionStartTimerSeconds"></span>
		     <div class="slice">
		    	<div class="bar"></div>
		        <div class="fill"></div>
     		 </div> 
     			    <!-- <h1  class="white-text" ></h1> -->
             </div>
     		 </div>
   
        <!--Grid column-->
        <!--     <div class="container-fluid img-fluid mt-5" style="background-image: url(/img/sessionStartBg.svg);background-repeat: no-repeat;width: auto;height: auto;background-position: center center;">
                <div class="flex-center">
                    <span class="draw-ellipse flex-center" style="z-index: 1">
                         <span class="draw-circle flex-center " >
                            <h1 id="sectionStartTimerSeconds" class="white-text" ></h1>
                    </span>
                    </span>
				</div>
            </div> -->
        <!--Grid column-->
    <%--    <div class="card card-image img-fluid" style="background-image: url(/img/sessionStartBg.svg);">--%>
    <%--        <img src="/img/sessionStartBg.svg" alt="sessionTimer" class="img-fluid">--%>
    </div>
</div>


                    <%--  ---------------------   EXERCISE DISPLAY SCREEN  ------------------------------   --%>
<%--Section Video Player--%>

<div class="row overflow-hidden hidden" id="exerciseDisplayScreen">
    <%--Videos - Exercise--%>
    <div class="col-md-8 d-flex ">
        <div class="row">
            <%for(int i=0 ; i < 4 ; i++){%>
            <div class="col-md-6 card text-center border-0  card-color" >
                <div class="card-body">
                    <h3 class="card-title hidden" style="font-family: whiteOn" id="displayExerciseName-<%=i%>"></h3>
                    <p class="card-text mt-4">
                        <video class="video-fluid z-depth-1 hidden" id="video-<%=i%>" src="" loop muted ></video>
                    </p>
                </div>
            </div>
            <%}%>
        </div>
    </div>

    <%--    Right BAR - - TIMER , REPS , TEMPLATED    --%>
    <div class="col-md-4 d-flex flex-row-reverse  ml-auto" >
        <div class="view text-center">
            <%--     BR IMAGE - GREEN STRIP       --%>
            <img src="/img/greenstrip.svg" class="img-fluid" style="width: auto;height: 100vh">

            <%--        TEMPLATE , ZONE         --%>
            <div class="mask center-block  ml-5 mt-3">
                <div class="container-fluid mt-5">
                    <span class=" ">
                        <b><p class="position-absolute text-center" style="color: #ffa700;margin-left: 110px;margin-top: -18px;font-size: 23px" id="displayZone"></p></b>
                    </span>
                    <a class="btn display-orange-button flex-center">
                        <span class="d-flex align-content-start">
                            <div>
                                <span class="Path-12197 flex-center" style="width: 57px;height: 57px;box-shadow: 0 3px 6px 0 rgba(0, 0, 0, 0.16);border-radius: 20px;margin-left: -10px"><img class="img-fluid" src="img/templateLogo.png" ></span>
                            </div>
                            &nbsp;
                            <div class="mt-2  ">
                                    <span class="d-flex align-content-start">
                                        <p class="white-text">Circuit60's</p>
                                    </span>
                                    <span class="d-flex align-content-start">
                                        <h5 class="black-text"><b id="displayTemplateName">Super Arm</b></h5>
                                    </span>
                            </div>
                        </span>
                    </a>

                    <%--        HR LINE 1            --%>
                    <hr style="color: greenyellow; background-color: greenyellow ;width: 150px;margin-top: 50px" class="center-block">

                    <%--        REPS            --%>
                    <div class="flex-center">
                        <span class="d-flex align-content-start white-text">
                            <div>
                                    <p style="font-size: 70px"><b id="displayRepsCount"></b></p>
                            </div>

                            <div class="mt-3 ml-3">
                                    <span class="d-flex align-content-start">
                                        <p style="font-size: 25px">MORE REPS</p>
                                    </span>
                                    <span class="d-flex align-content-start">
                                        <p style="font-size: 25px">TO GO</p>
                                    </span>
                            </div>
                        </span>
                    </div>

                    <%--        HR Line 2            --%>
                    <hr style="color: greenyellow; background-color: greenyellow ;width: 150px;margin-top: 10px" class="center-block">

                    <%--    TIMER   --%>
                    <div class="view flex-center mt-5">
                        <img src="/img/watch.svg" class="img-fluid">
                        <div class="mask flex-center white-text">
                            <h1 style="font-weight: 800;font-size: 50px" id="displayExerciseSecondsTimer"></h1>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>


                                <%--     -----------------------------REPS ITERATOR SCREEN ---------------------------   --%>

<div style="background-color: 	#F8F8F8 ; width: 100%;height: 100vh" class="flex-center hidden" id="repsIteratorScreen">
    <div class="row d-flex align-content-start">
        <span>
            <span class="">
             <b><p class="position-absolute text-center ml-3" style="color: #ffa700;margin-top: -18px;font-size: 23px;font-weight: 800" id="repsZoneText"></p></b>
         </span>
        <a class="btn display-orange-button flex-center" style="width: 280px;height: 100px">
                        <span class="d-flex align-content-start">
                            <div>
                                <span class="Path-12197 flex-center mt-1 ml-1" style="width: 57px;height: 57px;box-shadow: 0 3px 6px 0 rgba(0, 0, 0, 0.16);border-radius: 20px;margin-left: -10px"><img class="img-fluid" src="img/templateLogo.png" ></span>
                            </div>
                            &nbsp;
                            <div class="mt-2  ml-3">
                                    <span class="d-flex align-content-start ">
                                        <p class="white-text" style="font-size: 15px">Circuit60's</p>
                                    </span>
                                    <span class="d-flex align-content-start">
                                        <h5 class="black-text" style="font-size: 24px"><b id="repsTemplateNameText" style="font-weight: 800"></b></h5>
                                    </span>
                            </div>
                        </span>
        </a>
        </span>
        <span class="flex-center ml-5 mt-1">
            <p style="font-weight: 900;font-size: 70px">x </p>&nbsp;
        </span>
        <span class="flex-center ml-2">
                 <p style="font-size: 81px;font-weight: 900" id="repsIteratorText"> </p>
            </span>
    </div>
</div>
<%----%>
                                     <%--  ---------------------     BREAK TIMER SCREEN   --------------------      --%>

<%-- BREAK TIMER--%>
<div class="flex-center hidden" id="breakTimer" style="height: 100vh;width: 100%">
    <div  class=" text-center " >
        <h2> Water Break end in </h2>
        <!--Grid column-->
        <div class=" img-fluid mt-3" style="background-image: url(/img/breakScreen.svg);background-repeat: no-repeat;width: auto;height: auto;background-position: center center;">
            <div class="flex-center">
                <span class="draw-ellipse flex-center" style="z-index: 1;">
					  <span class="draw-circle flex-center " style="background-color: #00a2fe" >
                        <h1 id="breakTimerSeconds" class="white-text" ></h1>
                    </span>
                </span>
            </div>
        </div>

        <h2 class="mt-3">
            <b>"Being defeated is often a temporary condition.<br>
                Giving up is what makes it permanent."</b>
        </h2>
        <!--Grid column-->
        <%--    <div class="card card-image img-fluid" style="background-image: url(/img/sessionStartBg.svg);">--%>
        <%--        <img src="/img/sessionStartBg.svg" alt="sessionTimer" class="img-fluid">--%>
    </div>
</div>
<%----%>

<%----   -----------------   SWITCH SCREEN    ------  --------- ---%>

<%--       SWITCH SCREEN     --%>

<div class="flex-center hidden" id="switchScreen" style="height: 100vh;width: 100%">
    <img src="/img/switch.svg" class="img-fluid">
</div>

<%----%>
<%-- -------------      ON ERROR       -------------%>
<div class="row flex-center hidden" id="error">
    <h5 class="black-text" id="displayErrorText"></h5>
</div>
<%----%>


<!-- SCRIPTS -->

<!-- JQuery -->
<script type="text/javascript" src="../../js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="../../js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="../../js/mdb.min.js"></script>

<%--WebSocket--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="../../js/webSocket/control.js" ></script>
<!-- 
<script>
var progressBarOptions = {
		startAngle: -1.55,
		size: 200,
	    value: -0.1,
	    fill: {
			color: '#ffa500'
		}
	}

	$('.circle').circleProgress(progressBarOptions).on('circle-animation-progress', function(event, progress, stepValue) {
	});
	
$('#circle-a').circleProgress({
	value : 0.25,
	fill: {
		color: '#FF0000'
	}
});
</script> -->
</body>

</html>

