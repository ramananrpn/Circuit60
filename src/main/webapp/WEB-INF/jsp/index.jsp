<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Circuit60 |Home|</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
</head>
<body class="img-fluid" style="background-image: url('img/action-athlete-barbell-841130.png'); background-repeat: no-repeat; background-size: cover; background-position: center center;">
<div class="view img-fluid Rectangle-35" style="background-repeat: no-repeat; background-size: cover; background-position: center center;">
    <!--Admin Form-->
    <div class="row container">
        <div class="mask d-flex justify-content-center align-items-center">
            <div class="text-center white-text mx-5">
                <h1 class="mb-4">
                    <strong>Circuit60</strong
                </h1>
                <form name="adminForm" method="post" action="/adminLogin">
                    <div class="row">
                        <h5>
                            <input type="text" class="Rectangle-37" placeholder="Gym ID" id="gymId" autocomplete="off">
                            <a type="button" style="font-size: 20px" class="black-text mx-5" onclick="show()" id="gymIdSubmit">
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </h5>
                    </div>
                    <%-- Password  --%>
                   <div class="row hide-block" id="passwordContent" >
                       <h5>
                           <input type="password" class="Rectangle-37" placeholder="Password" id="password">
                           <submit><a type="button" style="font-size: 20px" class="black-text mx-5">
                               <i class="fas fa-arrow-right"></i>
                           </a></submit>
                           <button type="submit">yes</button>
                       </h5>
                   </div>
                </form>

            </div>
        </div>
    </div>
    <!--Admin Form-->
</div>
</body>
    <script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script>
        function show() {
            var content = document.getElementById("passwordContent");
            if(document.forms['adminForm'].gymId.value != "") {
                content.style.display = "block";
                document.getElementById("gymIdSubmit").style.display = "none";
            }
            else{
                alert("Please enter Gym ID");
            }
        }
    </script>
</html>
