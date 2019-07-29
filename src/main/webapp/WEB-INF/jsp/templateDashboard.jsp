<%@ page import="java.util.ResourceBundle" %>
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
    }
    a:hover
    {
        color: #0d0d0d;
    }
    .zone{
        font-weight: lighter;
        color: rgba(255,255,255,0.5);
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
        <nav class="text-center navbar navbar-expand-lg fixed navbar-light warning-color navbar-custom white-text" >

                        <div class="nav nav-text mr-auto ">
                            <a class="nav-item black-text  ml-4"><i class="far fa-arrow-alt-circle-left"></i></a>
                            <!--Template Name Dropdown -->
                            <span class="nav-item dropdown" style="margin-top: -10px"  >
                                <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown"
                                   aria-haspopup="true" aria-expanded="false">${templateName}</a>
                                <div class="dropdown-menu dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
                                    <c:forEach items="${templateList}" var="template">
                                        <%--      href condition to place redirection URL if its not current template in dropdown            --%>
                                    <a class="dropdown-item" href="<c:if test="${templateName!=template.templateName}">
                                                                            /templateDashboard/${template.templateName}
                                                                   </c:if>">
                                        <%--  Displaying Template Name --%>
                                        ${template.templateName}
                                    </a>
                                    </c:forEach>
                                </div>
                            </span>
                        </div>
            <div class="ml-auto">
                <button type="button" class="btn-sm btn-white btn-rounded" style="width: 150px">Add Excercise</button>
                <a><img src="../img/settings.svg" class="img-fluid"></a>
            </div>
        </nav>
    </div>
</header>
<div class="view text-center container-fluid" style="z-index: 1">
    <div class="row ml-3 jumbotron-fluid">
        <span class="card navbar Rectangle-9 white-text d-flex justify-content-center ml-5" >
            <ul class="nav navbar-nav" id="zone-navigation" >
                <c:set var = "url" scope = "session" value = "/templateDashboard/${templateName}"/>
<%--       Getting zone count value from property file         --%>
                <% ResourceBundle resource = ResourceBundle.getBundle("application-settings");
                   String val = resource.getString("zone.count");
//                   System.out.println(val);
                    for(int zoneCount = 1 ; zoneCount<=Integer.parseInt(val) ; zoneCount++){

                %>
                    <li class="nav-item ">
                        <a class="nav-link zone "  href="<c:out value="${url}"/>?zoneId=zone<%=zoneCount%>" onclick="changeActive(event)" id="zone<%=zoneCount%>">
                            Zone <%if(zoneCount<10){%><%=0%><%}%><%=zoneCount%>
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
        <span class="card base-r1 mt-3" style="margin-left: -30px;z-index: 1">
            <div class="row flex-center" style="">
                    <div class="text-center">
                         <a type="button" onclick="show()"><img src="../img/gym.svg" style="width: 40px;height: 40px;"></a>
                        <br>
                        <button type="button" class="set-btn-outline btn-rounded waves-effect" style="width: 180px;border: solid 1px #0d0d0d" >Add Exercise</button>
                    </div>
            </div>
        </span>
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


<%--Function get called on page load to make corresponding zone active--%>
    function changeActiveOnload(){
        var paramZone = new URLSearchParams(window.location.search).get("zoneId");
        // alert(paramZone );
        var zone = document.getElementById(paramZone);
        zone.classList.remove('zone');
        zone.classList.add('active');
    }
</script>
</body>

</html>

