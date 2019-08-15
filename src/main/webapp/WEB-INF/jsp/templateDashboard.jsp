<%@ page import="java.util.ResourceBundle" %>
<%@ page import="com.orcaso.circuit60.model.Zones" %>
<%--Developer Notes
    Specify ../ for all static files before context path
     --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Circuit60 |Exercise|</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="../css/mdb.min.css" rel="stylesheet">
    <!-- Your custom styles (optional) -->
    <link href="../css/style.css" rel="stylesheet">
</head>
<style>
    html,
    body,
    header,
    .view {
        background-color: #f2f5fa;
    }
    .view{
        margin-top: 120px;
    }
    hr{
        color: white;
        background-color: white;
    }

    a.active {
        font-weight: bold !important;
        color: white;
        margin-left: 20px;
    }
    a:hover
    {
        color: white;
    }
    .zone{
        font-weight: lighter;
        color: rgba(255,255,255,0.5);
    }
    .exerciseCustomise-card{
        border-radius: 33px;
        background-color: #f8f8f8;
        height: 45px;
        font-size: 15px;
        font-weight: 600;
    }
    .divider {
        width: 1px;
        margin: 6px 0 ;
        background: #9966FF;
        /*border-left: 1px solid #9966FF;*/
        /*height : 100px;*/
    }
    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        margin: 0;
    }
</style>

<body onload="changeActiveOnload()">


<header>
<%--  TopBar  --%>
    <!--Navbar -->

    <nav class="mb-1 navbar navbar-expand-lg top-navbar" >
        <a class="navbar-brand black-text">Circuit60</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-555"
                aria-controls="navbarSupportedContent-555" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent-555">
            <ul class="navbar-nav ml-auto nav-flex-icons" >
                <%-- BELL--%>
                <li class="nav-item">
                    <a class="nav-link waves-effect waves-light">
                        <img src="../img/notification.svg">
                    </a>
                </li>
                <li class="nav-item avatar">
                    <a class="nav-link p-0" href="#">
                        <img src="https://mdbootstrap.com/img/Photos/Avatars/avatar-5.jpg" class="rounded-circle z-depth-0"
                             alt="avatar image" height="35">
                    </a>
                </li>
            </ul>
        </div>
    </nav>
    <%--   Navbar     --%>
    <div class="container-fluid" style="margin-top: -15px;z-index: 2;position: absolute">
        <nav class="text-center navbar navbar-expand-lg fixed navbar-light navbar-custom white-text" style="background-color: #ffa700;">
						<div class="nav nav-text mr-auto ">
                            <a class="nav-item black-text  ml-4" href="/adminDashboard"><img src="../img/left.svg" class="img-fluid" style="width: 25px"></a>
                            <!--Template Name Dropdown -->
                            <span class="nav-item dropdown" style="margin-top: -10px"  >
                                <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">${template.getTemplateName()}</a>
                                <div class="dropdown-menu dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
                                    <c:forEach items="${templateList}" var="template">
                                        <%--      href condition to place redirection URL if its not current template in dropdown            --%>
                                    <a class="dropdown-item" href="<c:if test="${templateName!=template.templateName}">
                                                                            /templateDashboard/${template.templateId}
                                                                   </c:if>">
                                        <%--  Displaying Template Name --%>
                                        ${template.templateName}
                                    </a>
                                    </c:forEach>
                                </div>
                            </span>
                        </div>
            <div class="ml-auto mr-4">
                <%--Checking whether to show add exercise button or Start Section button--%>
                <c:choose>
                    <c:when test="${isZonePresent=='true' || (isTemplateActive == 'true' && (activeTemplate.getTemplateId()==template.getTemplateId()))}">
                        <c:choose>
                            <%--                        if Section is Started--%>
                            <c:when test="${(isTemplateActive=='true') && (activeTemplate.getTemplateId()==template.getTemplateId())}">
                                <button type="button" class="btn-md set-btn-outline-orange white-text" style="width: 150px" onclick="location.href='/adminCommand/${template.getTemplateId()}/stop?zoneId=${zoneId}'" >
                                    Stop Section
                                </button>
                                <button type="button" class="btn-md btn-white btn-rounded pauseButton" style="width: 150px" onclick="pauseCommand()">
                                    Pause Section
                                </button>
                                <button type="button" class="btn-md btn-white btn-rounded resumeButton hidden" style="width: 150px" onclick="resumeCommand()">
                                    Resume Section
                                </button>
                            </c:when>
                            <%--                        else section is not started--%>
                            <c:otherwise>
                                <button type="submit" form="timeConfigForm" class="btn-md set-btn-outline-orange white-text" style="width: 150px" onclick="location.href='/selectExercise/${template.getTemplateId()}?zoneId=${zoneId}'" >
                                    Save Section
                                </button>
                                <%--  Disabling Start Section button when a Template/Section is already started  --%>
                                <c:if test="${isTemplateActive!='true'}">
                                    <button type="button" class="btn-md btn-white btn-rounded" style="width: 150px" onclick="location.href='/adminCommand/${template.getTemplateId()}/start?zoneId=${zoneId}'">
                                        Start Section
                                    </button>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </c:when>

                    <c:otherwise >
                        <button type="button" class="btn-sm btn-white btn-rounded" style="width: 150px" onclick="location.href='/selectExercise/${template.getTemplateId()}?zoneId=${zoneId}'" >
                            Add Excercise
                        </button>
                    </c:otherwise>

                </c:choose>

                <a><img src="../img/settings.svg" class="img-fluid"></a>
            </div>
        </nav>
    </div>
</header>
<div class="view text-center container-fluid" style="">
    <div class="row ml-3 jumbotron-fluid flex-center">
        <span class="col-md-2 col-sm-2 card navbar Rectangle-9 white-text d-flex justify-content-center " >
            <ul class="nav navbar-nav" id="zone-navigation" >
                <c:set var = "url" scope = "session" value = "/templateDashboard/${template.getTemplateId()}"/>
<%--       Getting zone count value from property file         --%>
                <%
                    ResourceBundle resource = ResourceBundle.getBundle("application-settings");
                   String val = resource.getString("zone.count");
//                   System.out.println(val);
                    for(int zoneCount = 1 ; zoneCount<=Integer.parseInt(val) ; zoneCount++){

                %>
                    <li class="nav-item">
                        <a class="nav-link zone " style="margin-top: -20px"  href="<c:out value="${url}"/>?zoneId=zone<%=zoneCount%>" onclick="changeActive(event)" id="zone<%=zoneCount%>">
                            Zone <%if(zoneCount<10){%><%=0%><%}%><%=zoneCount%>
                        <%--Active element arrow--%>
<%--                            <img class="d-flex flex-row-reverse" src="../img/white-arrow.svg">--%>
                        </a>
                        <%if(zoneCount!=Integer.parseInt(val)){%>
                        <hr class="opacity-20">
                        <%}%>
                    </li>
                <%
                    }
                %>
<%--                <li class="nav-item zone">--%>
<%--                    <a class="nav-link " onclick="changeActive(event)">Zone 02</a><hr>--%>
<%--                </li>--%>
<%--                 <li class="nav-item zone">--%>
<%--                    <a class="nav-link " onclick="changeActive(event)">Zone 03</a><hr>--%>
<%--                </li>--%>
<%--                 <li class="nav-item zone">--%>
<%--                    <a class="nav-link "style="font-weight: lighter;" onclick="changeActive(event)">Zone 04</a><hr>--%>
<%--                </li>--%>
<%--                 <li class="nav-item zone">--%>
<%--                    <a class="nav-link " onclick="changeActive(event)">Zone 05</a><hr>--%>
<%--                </li>--%>
<%--                 <li class="nav-item zone">--%>
<%--                    <a class="nav-link " onclick="changeActive(event)">Zone 06</a>--%>
<%--                </li>--%>
            </ul>
        </span>

<%--      Display default Add exercide Icon and button when no exercise found for the current zone     --%>
        <c:if test="${isZonePresent=='false'}">
            <span class="col-md-9 col-sm-5 card base-r1 "  style="margin-left: -30px;z-index: 2;">
                <div class=" flex-center">
                    <c:choose>
                        <c:when test="${(isTemplateActive=='true') && (activeTemplate.getTemplateId()==template.getTemplateId())}">
                            <div class="text-center">
                                <h2>No Exercise Selected for this zone</h2>
                            </div>
                        </c:when>
                        <c:otherwise>
                             <div class="text-center">
                                <%--        Gym Dumbell add exercise LOGO    --%>
                                 <a type="button" href="/selectExercise/${template.getTemplateId()}?zoneId=${zoneId}">
                                     <img src="../img/gym.svg" style="width: 40px;height: 40px;">
                                 </a>
                                <br>
                                <%--     Add Exercise Button   --%>
                                <button type="button" onclick="location.href='/selectExercise/${template.getTemplateId()}?zoneId=${zoneId}'" class="set-btn-outline btn-rounded waves-effect" style="width: 180px;border: solid 1px #0d0d0d" >
                                    Add Exercise
                                </button>
                        </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </span>
        </c:if>

<%--    Display Exercise CRUD screen when exercise found for the current zone   --%>
        <c:if test="${isZonePresent=='true'}">
            <%--       Fetching Saved TIME CONFIG   --%>
            <%
                //exercise time
                Zones zones = (Zones) request.getAttribute("zoneDetails");
                int exMins = zones.getSeconds()/60;
                String exerciseMins = exMins < 10 ? "0"+exMins : ""+exMins ;
                int exSecs = zones.getSeconds()%60;
                String exerciseSeconds = exSecs < 10 ? "0"+exSecs : ""+exSecs ;
			    // Break Time
                int brMins = zones.getBreakTime()/60;
                String breakMins = brMins < 10 ? "0"+brMins : ""+brMins ;
                int brSecs = zones.getBreakTime()%60;
                String breakSeconds = brSecs < 10 ? "0"+brSecs : ""+brSecs ;
            %>
            <span class="col-md-9 col-sm-5 card base-r1 "  style="margin-left: -30px;z-index: 2;height: auto">
                <div class="container-fluid">
                    <br>
                    <%--         Excersie time reps brefore configure           --%>
                     <c:choose>
<%--                         WHEN SESSION STARTED - disable time config edit--%>
                         <c:when test="${(isTemplateActive=='true') && (activeTemplate.getTemplateId()==template.getTemplateId())}">
		                        <div class="row d-flex justify-content-center md-form">
		                            <div class="col-md-4 ">
		                                <span class="card exerciseCustomise-card flex-center">
		                                    <div class="row">
		                                        <span class="flex-center">
		                                            <img src="../img/clock.svg">
		                                            <p class="ml-2">Seconds Per Exercise</p>
		                                            <span style="color: #707070" class="flex-center ml-2">
		                                                <p ><%=exerciseMins%></p>
		                                                    <p >:</p>
		                                                <p><%=exerciseSeconds%></p>
                                                    </span>

		                                        </span>
		                                    </div>
		                                </span>
		                            </div>
<%--                                    REPS    --%>
		                            <div class="col-md-3 d-flex justify-content-center">
		                                <span class="card exerciseCustomise-card flex-center" style="width: 240px;" >
		                                    <div class="row">
		                                        <span class="flex-center">
		                                            <img src="../img/reps.svg">
                                                    <p class="ml-2">Reps</p>
		                                            <span style="color: #707070" class="flex-center ml-2">
		                                               <p>${zoneDetails.getReps()}</p>
		                                            </span>
		                                        </span>
		                                    </div>
		                                </span>
		                            </div>
<%--                                    BREAK   --%>
		                            <div class="col-md-3 d-flex justify-content-center">
		                                <span class="card exerciseCustomise-card flex-center" style="width: 283px;" >
		                                    <div class="row">
		                                        <span class="flex-center">
		                                            <img src="../img/break.svg">
		                                            <p class="ml-2">Break</p>
		                                                <span style="color: #707070" class="flex-center ml-2">
		                                                  <p><%=breakMins%></p>
		                                                    <p >:</p>
		                                                  <p><%=breakSeconds%>s</p>
		                                                 </span>
		                                        </span>
		                                    </div>
		                                </span>
		                            </div>
		                        </div>
		                    
						</c:when>
						<c:otherwise>
						<form id="timeConfigForm" method="post" action="/templateDashboard/${template.getTemplateId()}/${zoneId}">
		                        <div class="row d-flex justify-content-center md-form">
		                            <div class="col-md-4 ">
		                                <span class="card exerciseCustomise-card flex-center">
		                                    <div class="row">
		                                        <span class="flex-center">
		                                            <img src="../img/clock.svg">
		                                            <p class="ml-2">Seconds Per Exercise</p>
		                                            <a class="button mt-2" onclick="decreaseExerciseSeconds()">
		                                                <img src="../img/minusButton.svg">
		                                            </a>
		                                            <span style="color: #707070" class="flex-center ml-1">
		                                                <input type="number" id="exerciseMins" name="exerciseMins" class="form-control form-control-sm text-center" min="00" style="width: 25px" value="<%=exerciseMins%>"
		                                                       onchange="if(parseInt(this.value,10)<10)this.value='0'+this.value;">
		                                                <p >:</p>
		                                                <input type="number" id="exerciseSecs" name="exerciseSecs" class="form-control form-control-sm text-center" min="00" max="60" style="width: 25px" value="<%=exerciseSeconds%>"
		                                                       onchange="if(parseInt(this.value,10)<10)this.value='0'+this.value;">
		                                            </span>
		                                           <a class="button mt-2" onclick="increaseExerciseSeconds()">
		                                               <img src="../img/plusButton.svg">
		                                           </a>
		                                        </span>
		                                    </div>
		                                </span>
		                            </div>
		                            <div class="col-md-3 d-flex justify-content-center">
		                                <span class="card exerciseCustomise-card flex-center" style="width: 240px;" >
		                                    <div class="row">
		                                        <span class="flex-center">
		                                            <img src="../img/reps.svg">
		                                            <p class="ml-2">Reps</p>
		                                            <a class="button mt-2" onclick="decreaseReps()">
		                                                <img src="../img/minusButton.svg">
		                                            </a>
		                                            <span style="color: #707070" class="flex-center ml-1">
		                                               <input type="number" id="repsCount" name="repsCount" class="form-control form-control-sm text-center" min="0" style="width: 25px" value="${zoneDetails.getReps()}">
		                                            </span>
		                                           <a class="button mt-2" onclick="increaseReps()">
		                                               <img src="../img/plusButton.svg">
		                                           </a>
		                                        </span>
		                                    </div>
		                                </span>
		                            </div>
		                            <div class="col-md-3 d-flex justify-content-center">
		                                <span class="card exerciseCustomise-card flex-center" style="width: 283px;" >
		                                    <div class="row">
		                                        <span class="flex-center">
		                                            <img src="../img/break.svg">
		                                            <p class="ml-2">Break</p>
		                                            <a class="button mt-2" onclick="decreaseBreakSeconds()">
		                                                <img src="../img/minusButton.svg">
		                                            </a>
		                                                <span style="color: #707070" class="flex-center ml-1">
		                                                <input type="number" id="breakMins" name="breakMins" class="form-control form-control-sm text-center" min="00" style="width: 25px" value="<%=breakMins%>"
		                                                       onchange="if(parseInt(this.value,10)<10)this.value='0'+this.value;">
		                                                    <p >:</p>
		                                                <input type="number" id="breakSecs" name="breakSecs" class="form-control form-control-sm text-center" min="00" style="width: 25px" value="<%=breakSeconds%>"
		                                                       onchange="if(parseInt(this.value,10)<10)this.value='0'+this.value;">
		                                                 </span>
		                                           <a class="button mt-2" onclick="increaseBreakSeconds()">
		                                               <img src="../img/plusButton.svg">
		                                           </a>
		                                        </span>
		                                    </div>
		                                </span>
		                            </div>
		                        </div>
		                    </form>
						</c:otherwise>
					</c:choose>

                    <hr>
                    <%--       Exercise Display         --%>
                    <div class="row">
                        <%--        Loop to display fetched exercise                --%>
                        <c:forEach items="${exerciseList}" var="exercise">
                           <div class="col-md-3 col-sm-1 col-xs-1 d-flex justify-content-center " >
                                <div class="card text-center mb-3 border-0 card-color" >
                                    <div class="card-body">
                                        <h5 class="card-title">${exercise.getExerciseName()}</h5>
                                        <p class="card-text mt-4"><video class="video-fluid z-depth-1" src="${exercise.getUrl()}" autoplay loop muted></video></p>
                                    </div>
                                </div>
                           </div>
                        </c:forEach>
                    </div>

                    <%--        Progress Bar      --%>

  
                       <div class="row d-flex align-content-start">

                         <span class="ml-4">
                           <p id="exerciseIncreasingMinutes">00</p> <p id="exerciseIncreasingSeconds">:00</p>
                          </span>
                        <div class="container-fluid" style="width: 900px" >
                               <div class="progress " >
                                        <div class="progress-bar bg-success progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="50"
                                             id="progressBar"aria-valuemin="0" aria-valuemax="100">
                                        </div>
                                 </div>
                        </div>
                         <span class="mr-4">
                            <p id="exerciseDecreasingMinutes"><%=exerciseMins%></p><p id="exerciseDecreasingSeconds">:<%=exerciseSeconds%></p>
                         </span>


                    </div>




                    <br>
                    <hr>
                    <%--       Bottom button             --%>
                    <div class="d-flex flex-row-reverse">
                        <c:choose>
                            <c:when test="${(isTemplateActive=='true') && (activeTemplate.getTemplateId()==template.getTemplateId())}">
                                <button type="button" class="btn-sm set-text-violet pauseButton set-btn-outline" style="width: 180px;" onclick="pauseCommand()">
                                    Pause Section
                                </button>
                                <button type="button" class="btn-sm set-text-violet resumeButton set-btn-outline hidden" style="width: 180px;" onclick="resumeCommand()">
                                    Resume Section
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn-sm set-text-violet set-btn-outline" style="width: 180px;" onclick="location.href='/selectExercise/${template.getTemplateId()}?zoneId=${zoneId}'">
                                    Add / customize
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <br>
                </div>
            </span>
        </c:if>
    </div>

</div>

<!-- SCRIPTS -->
<!-- JQuery -->
<script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="../js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="../js/mdb.min.js"></script>

<script>
var currentSeconds='',increasingTimerMinutes='0',increasingTimerSeconds=0,timePercentage=0,percentageCount=1;
var increaseAndDecreaseTimer='';
    <%--function changeActive(e) {--%>
    <%--    &lt;%&ndash;alert("<c:out value="${templateName}"/>");&ndash;%&gt;--%>
    <%--    alert("<c:out value="${templateName}"/> " + e.target.id);--%>
    <%--    var elems = document.querySelector(".active");--%>
    <%--    if(elems !==null){--%>
    <%--        elems.classList.remove("active");--%>
    <%--        elems.parentElement.classList.add('zone');--%>
    <%--    }--%>
    <%--    e.target.parentElement.classList.remove('zone');--%>
    <%--    e.target.classList.add('active');--%>
    <%--    // alert(e.target.classList);--%>
    <%--}--%>
   <%-- <% if(${(isTemplateActive==true) && (activeTemplate.getTemplateId()==template.getTemplateId())})%> --%>
   	function startTimer(totalTimeNow){
   		int i=10;
   		var startTimerSeconds;
   		startTimerSeconds=setInterval(function(){
   			if(i==0){
   				clearInterval(startTimerSeconds);
   				printIncreasingAndDecreasingTime(totalTimeNow);
   			}
   			i--;
   		},1000);
   	}
	function printIncreasingAndDecreasingTime(totalTimeNow){
		 /* document.getElementById('exerciseDecreasingSeconds').innerHTML = totalTimeNow%60;
		 document.getElementById('exerciseDecreasingMinutes').innerHTML=totalTimeNow/60 < 10 ? '0'+totalTimeNow/60 : totalTimeNow/60; */
		 increaseAndDecreaseTimer = setInterval(function () {
			 			if(increasingTimerSeconds==60){
			 				increasingTimerMinutes++;
			 				document.getElementById('exerciseIncreasingMinutes').innerHTML=increasingTimerMinutes <10 ? '0'+increasingTimerMinutes :increasingTimerMinutes;
			 				increasingTimerSeconds=0;
			 				
			 			}
					document.getElementById('exerciseDecreasingMinutes').innerHTML=totalTimeNow/60 < 10 ? '0'+Math.floor(totalTimeNow/60) : Math.floor(totalTimeNow/60);
					document.getElementById('exerciseIncreasingSeconds').innerHTML = increasingTimerSeconds < 10?'0'+increasingTimerSeconds:increasingTimerSeconds;
					document.getElementById('exerciseDecreasingSeconds').innerHTML = totalTimeNow%60 < 10 ? '0'+totalTimeNow%60 : totalTimeNow%60;
					/* console.log((60-totalTime%60 < 10) ? '0'+60-totalTime%60 :60-totalTime%60); */
					currentSeconds=totalTimeNow;
					console.log(totalExerciseSeconds-totalTimeNow);
					if(Math.round(totalExerciseSeconds *(percentageCount/100)) == totalExerciseSeconds-totalTimeNow){
					  console.log('CONDITION SATISFIED'+' percentage ='+percentageCount);
					  document.getElementById('progressBar').style.width = percentageCount+'%';
					  percentageCount++;
					}
	            if (totalTimeNow == 0) {
	                clearInterval(increaseAndDecreaseTimer);
	                return;
	            }
	            totalTimeNow--;
	            increasingTimerSeconds++;
	        }, 1000)
		
	}
<%--Function get called on page load to make corresponding zone active--%>
    function changeActiveOnload(){
        var activeZone = "<c:out value="${zoneId}"/>";
        <%--alert(<c:out value="${zoneId}"/> );--%>
        var zone = document.getElementById(activeZone);
        zone.classList.remove('zone');
        zone.classList.add('active');
    }
</script>

<%--Scripts for time settings customization--%>
<script>
<%--  Seconds per Exercise Customization  --%>
    function increaseExerciseSeconds() {
        var secs = parseInt(document.getElementById('exerciseSecs').value);
        var mins = parseInt(document.getElementById('exerciseMins').value);
        // alert(secs +" "+mins);
        if(secs==59){
            document.getElementById('exerciseSecs').value = "00";
            document.getElementById('exerciseMins').value = (mins+1<10)?"0"+(mins+1):mins+1;
        }
        else {
            document.getElementById('exerciseSecs').value = ((secs + 1 < 10) ? ( "0" + (secs + 1)) :  (secs + 1));
        }
    }
    function decreaseExerciseSeconds() {
        var secs = parseInt(document.getElementById('exerciseSecs').value);
        var mins = parseInt(document.getElementById('exerciseMins').value);
        // alert(secs +" "+mins);
        if(secs>0 || mins>0){
            if(secs==1){
                document.getElementById('exerciseSecs').value = "00";
                if(mins>0)
                document.getElementById('exerciseMins').value = (mins-1<10)?"0"+(mins-1):mins-1;
            }
            else {
                document.getElementById('exerciseSecs').value = ((secs - 1 < 10) ? ( "0" + (secs - 1)) :  (secs - 1));
            }
        }
    }
    <!--Reps Customization-->
    function increaseReps() {
        var repsCount = parseInt(document.getElementById('repsCount').value);
        document.getElementById('repsCount').value = repsCount+1;
    }
    function decreaseReps() {
        var repsCount = parseInt(document.getElementById('repsCount').value);
        if(repsCount>1)
        document.getElementById('repsCount').value = repsCount-1;
    }

//    Break time customization
function increaseBreakSeconds() {
    var secs = parseInt(document.getElementById('breakSecs').value);
    var mins = parseInt(document.getElementById('breakMins').value);
    // alert(secs +" "+mins);
    if(secs==59){
        document.getElementById('breakSecs').value = "00";
        document.getElementById('breakMins').value = (mins+1<10)?"0"+(mins+1):mins+1;
    }
    else {
        document.getElementById('breakSecs').value = ((secs + 1 < 10) ? ( "0" + (secs + 1)) :  (secs + 1));
    }
}
function decreaseBreakSeconds() {
    var secs = parseInt(document.getElementById('breakSecs').value);
    var mins = parseInt(document.getElementById('breakMins').value);
    // alert(secs +" "+mins);
    if(secs>0 || mins>0){
        if(secs==1){
            document.getElementById('breakSecs').value = "00";
            if(mins>0)
                document.getElementById('breakMins').value = (mins-1<10)?"0"+(mins-1):mins-1;
        }
        else {
            document.getElementById('breakSecs').value = ((secs - 1 < 10) ? ( "0" + (secs - 1)) :  (secs - 1));
        }
    }
}

//TOGGLE PAUSE and RESUME Button
    function pauseCommand() {
        alert
        $.ajax({
            url:"/adminCommand/${template.getTemplateId()}/pause?zoneId=${zoneId}",
            method:"GET",
        success: function(response) {
            var pause = document.querySelectorAll(".pauseButton");
            [].forEach.call(pause, function (pauseButton) {
                pauseButton.classList.toggle('hidden');
            });
            var resume = document.querySelectorAll(".resumeButton");
            [].forEach.call(resume, function (resumeButton) {
                resumeButton.classList.toggle('hidden');
            }); 
            
        },
        error : function(){
        }
        });
        clearInterval(increaseAndDecreaseTimer);
    }

    function resumeCommand() {
        $.ajax({
            url:"/adminCommand/${template.getTemplateId()}/resume?zoneId=${zoneId}",
            method:"GET",
            success: function(response) {
                var pause = document.querySelectorAll(".pauseButton");
                [].forEach.call(pause, function (pauseButton) {
                    pauseButton.classList.toggle('hidden');
                });
                var resume = document.querySelectorAll(".resumeButton");
                [].forEach.call(resume, function (resumeButton) {
                    resumeButton.classList.toggle('hidden');
                });
            },
            error : function(){
            }
        });
        printIncreasingAndDecreasingTime(currentSeconds);
        
    }
</script>
<c:if test="${(isTemplateActive=='true') && (activeTemplate.getTemplateId()==template.getTemplateId())}">
<script>
startTimer(${zoneDetails.getSeconds()});
/* printIncreasingAndDecreasingTime(${zoneDetails.getSeconds()}); */
var totalExerciseSeconds = ${zoneDetails.getSeconds()}?${zoneDetails.getSeconds()}:'';
document.getElementById('progressBar').style.width = '0%';
</script>
</c:if>
<%----%>
</body>
</html>

