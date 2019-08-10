<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Material Design Bootstrap</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="css/mdb.min.css" rel="stylesheet">
    <!-- Your custom styles (optional) -->
    <link href="css/style.css" rel="stylesheet">
</head>
<style>
    p,h5,h3{
        text-transform: none;
    }
</style>
<body class="overflow-hidden">

<div class="row hidden">
    <%--Videos--%>
    <div class="col-md-8 d-flex ">
        <div class="row">
            <%for(int i=0 ; i < 4 ; i++){%>
            <div class="col-md-6 card text-center border-0  card-color" >
                <div class="card-body">
                    <h3 class="card-title" style="font-family: whiteOn">Push Ups</h3>
                    <p class="card-text mt-4">
                        <video class="video-fluid z-depth-1" src="../../exercises/chest/Pull%20Ups.mp4" autoplay loop muted></video>
                    </p>
                </div>
            </div>
            <%}%>
        </div>

    </div>
    <%--    Right    --%>
    <div class="col-md-4 d-flex flex-row-reverse  ml-auto" >
        <div class="view text-center">
            <%--     BR IMAGE - GREEN STRIP       --%>
            <img src="/img/greenstrip.svg" class="img-fluid" style="width: auto;height: 100vh">

            <%--        TEMPLATE , ZONE         --%>
            <div class="mask center-block  ml-5 mt-3">
                <div class="container-fluid mt-5">
                    <span class=" ">
                        <b><p class="position-absolute text-center" style="color: #ffa700;margin-left: 110px;margin-top: -18px;font-size: 23px">ZONE 01</p></b>
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
                                        <h5 class="black-text"><b>Super Arm</b></h5>
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
                                    <p style="font-size: 70px"><b>02</b></p>
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
                            <h1 style="font-weight: 800;font-size: 50px">02</h1>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>


<div style="background-color: 	#F8F8F8 ; width: 100%;height: 100vh" class="flex-center hidden" id="repsIteratorScreen">
    <div class="row d-flex align-content-start">
        <span>
            <span class="">
             <b><p class="position-absolute text-center ml-3" style="color: #ffa700;margin-top: -18px;font-size: 23px;font-weight: 800" id="repsZoneText">ZONE 01</p></b>
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
                                        <h5 class="black-text" style="font-size: 24px"><b id="repsTemplateNameText" style="font-weight: 800">Super Arm</b></h5>
                                    </span>
                            </div>
                        </span>
        </a>
        </span>
        <span class="flex-center ml-5 mt-1">
            <p style="font-weight: 900;font-size: 70px">x </p>&nbsp;
        </span>
        <span class="flex-center ml-2">
                 <p style="font-size: 81px;font-weight: 900" id="repsIteratorText"> 2 REPS</p>
            </span>
    </div>
</div>




<!-- SCRIPTS -->
<!-- JQuery -->
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="js/mdb.min.js"></script>
</body>

</html>
