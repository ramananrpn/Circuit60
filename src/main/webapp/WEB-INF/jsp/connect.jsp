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
</style>

<%--set isStarted var globally--%>
<script>
    var isStarted = "<c:out value="${isTemplateActive}"></c:out>"
</script>
<body>
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

<%--After Start Screen--%>
<div id="sessionStartTimer" class="container-fluid text-center hidden mt-5" >
    <h2>The Session will start in </h2>
    <!--Grid column-->

        <div class="container-fluid img-fluid mt-5" style="background-image: url(/img/sessionStartBg.svg);background-repeat: no-repeat;width: auto;height: auto;background-position: center center;">
            <div class="flex-center">
                <span class="draw-ellipse flex-center" style="z-index: 1">
                     <span class="draw-circle flex-center " >
                        <h1 id="sectionStartTimerSeconds" class="white-text" ></h1>
                    </span>
                </span>

            </div>
        </div>
    <!--Grid column-->
<%--    <div class="card card-image img-fluid" style="background-image: url(/img/sessionStartBg.svg);">--%>
<%--        <img src="/img/sessionStartBg.svg" alt="sessionTimer" class="img-fluid">--%>
</div>

<%--Section Video Player--%>
<div class="container-fluid hidden" id="exercisePlayer">
    <h1>SECTION RUNNING</h1>
</div>


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


</body>

</html>

