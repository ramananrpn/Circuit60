
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
        background-image: linear-gradient(119deg, #ffe943, #c9138a);
    }
    .next{
        width: 25px;
        height: 35px;
        object-fit: contain;
    }
</style>
<body>
<!-- Full Page Intro -->
<div class="view" style="background-image: url('img/action-athlete-barbell-841130.png'); background-repeat: no-repeat; background-size: cover; background-position: center center;">
    <!-- Mask & flexbox options-->
    <div class="mask rgba-gradient align-items-center">
        <!-- Content -->
        <div class="container flex-center">
            <!--Grid row-->
            <div class="row">
                <!--Grid column-->
                <div class="col-md-12 white-text text-center flex-center">
                    <div class="container">
                    <img src="img/Logo.png" class="img-fluid ml-4">
                        <form class="text-center mt-4" name="adminForm" method="post" action="/adminLogin">
                            <div class="input-group-append" id="gymId" autocomplete="off">
                                <input type="text" class="form-control form-rounded input-lg " placeholder="Gym ID" style="width: 320px" autocomplete="off" name="gymId">
                                <span ><a type="button" style="margin-left: -40px" onclick="show()" id="gymIdSubmit"><img src="img/Next.svg" class="img-responsive next"></a></span>
                            </div>
                            <div class="input-group-append mb-1 hide-block-visibility" id="passwordContent">
                                <input type="password"  class="form-control form-rounded input-lg " placeholder="Password" style="width: 320px" name="password">
                                <span><input type="image" src="img/Next.svg" class="submit img-responsive next" style="margin-left: -40px" ></span>
                            </div>
                        </form>
                    </div>
                </div>
                <!--Grid column-->
            </div>
            <!--Grid row-->
        </div>
        <!-- Content -->
    </div>
    <!-- Mask & flexbox options-->
</div>
</div>
<!-- Full Page Intro -->

<!-- SCRIPTS -->
<script>
    function show() {
        var content = document.getElementById("passwordContent");
        if(document.forms['adminForm'].gymId.value != "") {
            document.getElementById("gymIdSubmit").style.visibility = "hidden";
            content.style.visibility = "visible";
        }
        else{
            alert("Please enter Gym ID");
        }
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

