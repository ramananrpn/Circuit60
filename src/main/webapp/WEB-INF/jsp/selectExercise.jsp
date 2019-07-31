<%--
  User: Ramanan
  Date: 2019-07-22
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="org.apache.commons.logging.Log" %>
<%@ page import="org.apache.commons.logging.LogFactory" %>

<%
//    Get a reference to the logger for this class
    Log logger = LogFactory.getLog( this.getClass() );
//   Getting Resource File
    ResourceBundle resource = ResourceBundle.getBundle("application-settings");
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="css/mdb.min.css" rel="stylesheet">
    <!-- custom styles  -->
    <link href="css/style.css" rel="stylesheet">

    <%--Sortable to make draggable components (selected exercise need to be sorted)--%>
    <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>

</head>
<style>
    .Rectangle-21 {
        width: 180px;
        height: 850px;
        background-color: #5e31e9;
    }
    .view{
        margin-top: 90px;
    }
    hr{
        color: white;
        background-color: white;
    }
    .zone{
        font-weight: lighter;
        color: rgba(255,255,255,0.5);
    }
    .left{
        margin-left: 20px;
    }
    .select-border{
        border-radius: 20px;
        border: solid 1px #00d050;
    }
    body{
        overflow-x: hidden;
        background-color: #f2f5fa;
    }
    .card-color{
        background-color: #f2f5fa;
    }
    .sortable-card {
        width: 194px;
        height: 70px;
        background-color: #fe5562;
        border-radius: 20px 0px 0px 20px;
        margin-top: 20px;
    }
    .sortable-blur-text{
        font-size: 50px;
        opacity: 0.14;
    }
    .hidden{
        display:none;
    }
</style>
<body>

<header>
    <%--  TopBar  --%>
    <!--Navbar -->
    <nav class="mb-1 navbar navbar-expand-lg top-navbar fixed-top" style="z-index: 2">
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
                        <img src="img/notification.svg">
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
</header>
<div class="row">
    <section class="col-md-1">
        <div class="Rectangle-21 navbar">
            <ul class="nav white-text text-center center-block" style="margin-top: -50px">
                <li class="nav-item d-flex float-left zone" >
                    <a>Favourites</a>
                </li><br>
                <%--        Getting exercise category from property File        --%>
                <%
                    String[] exerciseCategory = resource.getString("exercise.categories").split(";");
                    logger.info("Exercise Categories retrieved from property file - " + exerciseCategory[0]);
                %>
                <%for(String exerciseCategoryName : exerciseCategory){%>
                    <li class="nav-item zone">
                        <a class="nav-link ">
                            <%=exerciseCategoryName%>
                        </a><hr>
                    </li>
                <%}%>

<%--                <li class="nav-item zone">--%>
<%--                    <a class="nav-link ">Biceps</a><hr>--%>
<%--                </li>--%>
<%--                <li class="nav-item zone">--%>
<%--                    <a class="nav-link ">Triceps</a><hr>--%>
<%--                </li>--%>
<%--                <li class="nav-item zone">--%>
<%--                    <a class="nav-link ">Fat</a><hr>--%>
<%--                </li>--%>
<%--                <li class="nav-item zone">--%>
<%--                    <a class="nav-link ">Shoulder</a><hr>--%>
<%--                </li>--%>
<%--                <li class="nav-item zone">--%>
<%--                    <a class="nav-link ">Leg</a><hr>--%>
<%--                </li>--%>
<%--                <li class="nav-item zone">--%>
<%--                    <a class="nav-link ">Abs</a><hr>--%>
<%--                </li>--%>
<%--                <li class="nav-item zone">--%>
<%--                    <a class="nav-link ">Fit</a>--%>
<%--                </li>--%>
            </ul>
        </div>
    </section>
    <section class="view col-md-10 container "  >
            <div class="row">
                <div class="col-md-6 row d-flex justify-content-center" style="font-size: 24px">
                    <a class="mt-2" href="/templateDashboard/${template.getTemplateId()}?zoneId=${zoneId}">
                        <img src="img/left.svg" class="img-fluid" style="width: 25px">
                    </a>
                    <%--       Getting zone excercise ocunt value from property file         --%>
                    <%
                        String exerciseCount = resource.getString("zone.exercise.count");
                    %>
                    <%--    setting var in script  for exercise Count  --%>
                    <script>
                        var allowedNumberOfExerciseToSelect = "<%=exerciseCount%>";
                    </script>
                    <%--  --%>
                    <span class="ml-3">
                        <p >Select upto <%=exerciseCount%> exercises for</p>
                    </span> &nbsp;
                    <span>
                        <b>
                            <!-- Zone DropDown -->
                            <a class="dropdown-toggle mr-4"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${zoneId}</a>
                            <span class="dropdown-menu">
                                <%--       Getting zone count value from property file         --%>
                                <%
                                    String zoneCountValue = resource.getString("zone.count");
                                    logger.info("zoneCountValue in selectExercise.jsp - " + zoneCountValue);
                                    for(int zoneCount = 1 ; zoneCount<=Integer.parseInt(zoneCountValue) ; zoneCount++){
                                %>
                                      <a class="dropdown-item"
                                         <% if(!request.getParameter("zoneId").equals("zone"+zoneCount)){%>}
                                         href="/selectExercise?zoneId=zone<%=zoneCount%>"
                                         <%}%>
                                      >
                                           Zone <%if (zoneCount < 10) {%><%=0%><%}%><%=zoneCount%>
                                      </a>
                                <%
                                    }
                                %>
                            </span>
                        </b>
                    </span>

                </div>

                <div class="ml-auto d-flex flex-row-reverse mr-4 " >
                    <button type="button" class="btn-sm btn btn-rounded set-text-white" style="width:120px ; background-color: #5e31e9;">Save</button>
                </div>
            </div>

        <hr class="mr-5">

        <div class=" row ml-2 d-flex justified-content-center "  >
            <div class="col-md-10" >
                <div class="row ml-5" style="margin-left: 20px" >
                    <%
                        File directory = new File(System.getProperty("user.dir")+"/src/main/webapp/exercises/chest/");
                        String[] fileList = directory.list();
                        for(String name:fileList){
                            System.out.println(name);
                        }%>
                    <% for(int i=0 ; i<8 ; i++) {%>

                    <div class="col-md-3 mt-2 d-flex justify-content-center ml-5"   onclick="myFunction(this)">
<%--                        <label>--%>
                            <input type="checkbox" name="chk1" id="ex<%=i%>" value="val1" class="hidden" autocomplete="off">
                            <div class="card text-center mb-3 border-0 mt-3 card-color" >
                                <div class="card-body">
                                    <h5 class="card-title">Push Ups</h5>
                                    <p class="card-text mt-4">
                                        <video class="video-fluid z-depth-1" src="../../exercises/chest/Pull%20Ups.mp4" autoplay loop muted></video>
                                    </p>
                                </div>
                            </div>
<%--                        </label>--%>
                    </div>
                    <%}%>
                </div>

            </div>
            <div class="col-md-2">
                <div class="row d-flex justify-content-center ml-4">
                    <p class="text-danger" style="font-size: 14px">Selected Exercise</p>
                </div>
                <section class="row">
                    <ul id="sortable" >
                        <%for(int i=1 ; i<5 ;i++){%>
                        <div class="card sortable-card  white-text" >
                                <p class="mt-3 center-block">Exercise <%=i%></p>
                                <p class="sortable-blur-text d-flex flex-row-reverse mr-4" style="margin-top: -40px;"><%="0"+i%></p>
                        </div>
                        <%}%>
                    </ul>
                </section>
            </div>
        </div>

    </section>
</div>

<!-- SCRIPTS -->
<script>
    function myFunction(a) {
        // alert("ram");
        // alert(allowedNumberOfExerciseToSelect);
        var count = document.querySelectorAll(".select-border").length;
        if(count>=allowedNumberOfExerciseToSelect && !(a.classList.contains("select-border"))){
            alert("Sorry! you can select only "+allowedNumberOfExerciseToSelect+" Exercises");
        }
        else{
            a.classList.toggle("select-border");
        }
        a.stopPropagation? a.stopPropagation() : a.cancelBubble = true;
    }
    function success(id) {
        alert(id);
    }
</script>

<%--Script to make selected exercise box re-arrangeble--%>
<script>
    $("#sortable").sortable();
</script>

<!-- JQuery -->
<script type="text/javascript" src="../../js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="../../js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="../../js/mdb.min.js"></script>

</body>

</html>

