<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Circuit60 |Welcome|</title>
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

    html,
    body,
    header,
    .view {
        background-color: #f2f5fa;
    }

</style>
<body>
<header>
    <%--   Navbar     --%>
    <div class="container-fluid mb-1">
        <nav class="text-center navbar navbar-light warning-color navbar-custom white-text">
            <div class="nav-text ml-5">
                Hi <%=session.getAttribute("gymId")%> ,
                <%
                    DateFormat dateFormat = new SimpleDateFormat("hh.mm aa");
                    String dateString = dateFormat.format(new Date()).toString();
                %>
                It's <%=dateString%>
            </div>
        </nav>
    </div>
</header>
<!--Main Navigation-->

<%--   Create Template Panel --%>

<%--      Add Logo     --%>
<!-- Grid row -->
<div class="container-fluid ">

        <%--    Add Template Card   --%>
        <!-- Grid column -->
        <div class="row">
        <div class="col-lg-2 col-md-2 mt-5 ml-4">
            <div class="text-center Rectangle-1378 " id="createTemplate">
                <div class="row " >
                    <div class="flex-center">
                        <span class="Path-12197 ml-4 mt-3 flex-center"><img class="img-fluid" src="img/Union 5.svg"></span>
                        <span class="add ml-3 Add-Template mt-3" id="panelHeaderText">Add Template</span>
                    </div>
                </div>
                <div class="row flex-center">
                    <div class="text-center Rectangle-1379 flex-center">
                        <a type="button" onclick="show()"><img src="img/gym.svg" style="width: 40px;height: 40px;"></a>
                    </div>
                </div>
            </div>
            <form method="post" action="/adminDashboard">
                <%-- Add template form --%>
                <div class="text-center Rectangle-1378 hide-block-display" id="createForm">
                    <div class="row " >
                        <div class="flex-center">
                            <span class="Path-12197 ml-4 mt-3 flex-center"><img class="img-fluid" src="img/Union 5.svg"></span>
                            <span class="add ml-3 Add-Template mt-3 " >Name the Template</span>
                        </div>
                    </div>
                    <div class="row flex-center" >
                        <div class="text-center Rectangle-1379 flex-center">
                            <div class="text-center">
                                <input type="text" id="templateNameInput" class="form-control text-center form-rounded" placeholder="Name of Template" name="templateName" style="font-size: 14px" autocomplete="off" required>
                                <input type="hidden" name="gymId" value="<%=session.getAttribute("gymId")%>">
                                <br>
                                <button type="button" class="btn-sm set-btn-outline set-text-violet btn-rounded waves-effect" style="width: 80px;" onclick="showTemplate()">Cancel</button>
                                <button type="button" class="btn-sm btn-rounded set-text-white" style="width: 80px;background-color: #5e31e9;" onclick="uploadLogo()">create</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%--      Upload Image      --%>
                <div class="text-center Rectangle-1378 hide-block-display" id="uploadLogo">
                    <div class="row " >
                        <div class="flex-center">
                            <span class="Path-12197 ml-4 mt-3 flex-center"><img class="img-fluid" src="img/Union 5.svg"></span>
                            <span class="add ml-3 Add-Template mt-3" id="templateName"></span>
                        </div>
                    </div>
                    <div class="row flex-center" >
                        <div class="text-center Rectangle-1379 flex-center">
                            <div>
                                <p>Want to Upload Logo?</p>
                                <br>
                                <button type="submit" class="btn-sm set-btn-outline set-text-violet btn-rounded waves-effect" style="width: 80px;" onclick="showTemplate()">Skip</button>
                                <button type="button" class="btn-sm btn-rounded set-text-white" style="width: 80px;background-color: #5e31e9;" formaction="/">Upload</button>
                            </div>
                        </div>
                    </div>
                </div>
            <%--            --%>
            </form>
        </div>
            <%
                int count=1;
            %>
<%--            <p>HELLO ${templateList}</p>--%>

        <c:forEach items="${templateList}" var="template">
            <%
//                System.out.println("Hii");
                if(count%5==0){
            %>
            <div class="row">
                <%
                    }
                %>
        <%--   Template Details Card     --%>
        <!-- Grid column -->
        <a class="col-lg-2 col-md-2 mt-5 ml-4" href="/templateDashboard/${template.templateName}">
            <div class="text-center Rectangle-1378 " >
                <div class="row " >
                    <div class="flex-center">
                        <span class="Path-12197 ml-4 mt-3 flex-center"><img class="img-fluid" src="img/Union 5.svg"></span>
                        <span class="add ml-3 Add-Template mt-3" >${template.templateName}</span>
                    </div>
                </div>
                <div class="row flex-center">
                    <div class="text-center Rectangle-1379 flex-center">

                    </div>
                </div>
            </div>
        </a>
        <%
            count++;
            if(count%5==0){
        %>
    </div>
    <%
            }
    %>
    </c:forEach>

    <%
//        System.out.println("hello");
        if(count%5!=0){%></div><%}%>
</div>

<!-- SCRIPTS -->
<script>
    function show() {
        document.getElementById("createTemplate").style.display = "none";
        document.getElementById("createForm").style.display = "block";
        document.getElementById("uploadLogo").style.display = "none";
    }
    function showTemplate() {
        document.getElementById("createTemplate").style.display = "block";
        document.getElementById("createForm").style.display = "none";
        document.getElementById("uploadLogo").style.display = "none";
    }
    function uploadLogo() {
        document.getElementById("createForm").style.display = "none";
        document.getElementById("templateName").innerHTML = document.getElementById("templateNameInput").value;
        document.getElementById("uploadLogo").style.display = "block";
        document.getElementById("createTemplate").style.display = "none";
    }
</script>
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

