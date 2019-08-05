
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

</style>
<body>
<%-- Before Start Screen --%>
    <!-- Full Page Intro -->
    <div class="view" style="background-image: url('../../img/action-athlete-barbell-841130.png'); background-repeat: no-repeat; background-size: cover; background-position: center center;" id="beforeStart">
        <!-- Mask & flexbox options-->
        <div class="mask rgba-gradient align-items-center" >
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
        <!-- Mask & flexbox options-->
    </div>
    <!-- Full Page Intro -->

<%--After Start Screen--%>
<div id="sessionStartTimer" class="container-fluid text-center hidden mt-5" >
    <h2>The Session will start in </h2>
    <div class="container-fluid" >
        <img src="/img/sessionStartBg.svg" alt="sessionTimer" class="img-fluid">
    </div>

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

