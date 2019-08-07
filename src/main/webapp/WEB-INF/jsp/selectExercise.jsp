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
    <!-- JQuery -->
	<script type="text/javascript" src="../../js/jquery-3.4.1.min.js"></script>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="css/mdb.min.css" rel="stylesheet">
    <!-- custom styles  -->
    <link href="css/style.css" rel="stylesheet">
    <!--Jquery for ajax-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

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
    .active {
      font-weight: bold !important;
      color: white;
      margin-left: 20px;
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
<body  onload="activeOnLoad()">
 
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
                <%-- <c:set var="category" value="categoryies"></c:set> --%>
                <%
                    String[] exerciseCategory = resource.getString("exercise.categories").split(";");
                    logger.info("Exercise Categories retrieved from property file - " + exerciseCategory[0]);
                %>
                
                <% String categoryName = "Chest";
                for(String exerciseCategoryName : exerciseCategory){%>
                    <li class="nav-item ">
                        <a class="nav-link zone" name="category" id="<%=exerciseCategoryName%>id"  onclick="changeCategoryName('<%=exerciseCategoryName%>')">
                             <%=exerciseCategoryName%>
                        </a><hr>
                    </li>
                <%}%>
               
					<%-- <c:out var="categoryName"></c:out>t type="hidden" name="categoryHidden" id="categoryHidden" > --> --%>
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
<%--                <li classprintln="nav-item zone">--%>
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
    
    
    <section class="view col-md-11 container-fluid "  >
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
                    <button type="button" class="btn-sm btn btn-rounded set-text-white" style="width:120px ; background-color: #5e31e9;" onclick="saveSelectedExcercise()">Save</button>
                </div>
            </div>

        <hr class="mr-5">
        <div class=" row ml-2 d-flex justified-content-center "  >
            <div class="col-md-10" >
                <div class="row ml-5" style="margin-left: 20px" id="videofiles" >
<!--                 	<input type="hidden" name="categoryHidden" id="categoryHidden" > -->
                    <%
                        File directory = new File(System.getProperty("user.dir")+"/src/main/webapp/exercises/"+categoryName.toLowerCase()+"/");
                        String[] fileList = directory.list();
                        int number=0;
                        String path="";
                     	for(String name:fileList){
                            System.out.println(name);
                            path="../../exercises/"+categoryName.toLowerCase()+"/"+name; %>
                           
                    <div class="col-md-3 mt-2 d-flex justify-content-center ml-5" id="<%=categoryName+number+"borderClass"%>"   onclick="myFunction(this,'<%=categoryName+number%>','<%=name.substring(0,name.indexOf('.'))%>','<%=path%>','<%=categoryName%>')">
                            <div class="card text-center mb-3 border-0 mt-3 card-color" >
                                <div class="card-body">
                                    <h5 class="card-title"><%=name.substring(0,name.indexOf('.')) %></h5>
                                    <p class="card-text mt-4">
                                        <video class="video-fluid z-depth-1" id="<%=categoryName+number++%>" src="<%=path%>"  autoplay loop muted></video>
                                      </p>
                                </div>
                            </div>
                    </div>
                    <%}%>
                </div>

            </div>
            <div class="col-md-2 ">
                <div class="row d-flex justify-content-center ml-4">
                    <p class="text-danger" style="font-size: 14px">Selected Exercise</p>
                </div>
                <section class="row ">
                    <span class="d-flex flex-row-reverse">
                        <ul id="sortable" >
       <%--                  <%for(int i=1 ; i<6 ;i++){%>
                        <li class="card sortable-card white-text row" id="'+array[i].id+'" >
                                <span style=categoryArray"margin-left: -10px" class="mt-2">
                                     <at type="hidden" name="categoryHidden" id="categoryHidden" > --> onclick="alert('hi');"><img src="img/exerciseMinus.svg" class="img-fluid mt-3"></a>
                                </span>
                                <span class=" mt-3" style="z-index: 1">
              
<script>                      <p >'+array[i].exerciseName+'</p>
                                </span>
                                <span class="row mt-2" style="position: absolute;margin-left: 90px;">
                                    <p class="sortable-blur-text mr-4 " style=""><%="0"+i%></p>
                                </span>
                        </li>
                        <%}%> --%>
                    </ul>
                    </span>

                </section>
            </div>
        </div>

    </section>
</div>

<!-- SCRIPTS -->
<script>

var array= new Array();
var flag="notSelected";
var currentCategory ='',selectedcategory='';
  /*method to remove the selectedExercise using execise Id*/
  function removeSelectedExcercise(selectedExcerciseId,category){
	var str='';
	console.log(selectedExcerciseId);
	for(var i=0;i<array.length;i++){
		if(array[i].id == selectedExcerciseId){
			selectedCategory=array[i].category;
			console.log("removable object",array[i].id,array[i].exerciseName,array[i].url);
			array.splice(i,1);//removing the object in the matching index
			console.log(array);
			
		}/* else{
			 str+= '<li class="card sortable-card white-text row" id="'+array[i].id+'" ><span style="margin-left: -10px" class="mt-2"><a onclick="removeSelectedExcercise('+"'"+array[i].id+"'"+')"><img src="img/exerciseMinus.svg" class="img-fluid mt-3"></a>'
			+'</span><span class=" mt-3" style="z-index: 1"><p >'+array[i].exerciseName+'</p></span><span class="row mt-2" style="position: absolute;margin-left: 90px;"><p class="sortable-blur-text mr-4 " style="">'+i+'</p></span></li>';
			console.log(str);
		} */
	}  
	//checking condition 
	for(var i=0;i<array.length;i++){
		 str+= '<li class="card sortable-card white-text row" id="'+array[i].id+'" ><span style="margin-left: -10px" class="mt-2"><a onclick="removeSelectedExcercise('+"'"+array[i].id+"'"+','+"'"+array[i].category+"'"+')"><img src="img/exerciseMinus.svg" class="img-fluid mt-3"></a>'
			+'</span><span class=" mt-3" style="z-index: 1"><p >'+array[i].exerciseName+'</p></span><span class="row mt-2" style="position: absolute;margin-left: 90px;"><p class="sortable-blur-text mr-4 " style="">'+i+'</p></span></li>';
			console.log(str);
	}
	console.log("category",selectedCategory);
	console.log(currentCategory,selectedCategory);
	if(selectedCategory == currentCategory){
		if(document.getElementById(selectedExcerciseId+"borderClass").classList.contains("select-border")){
			document.getElementById(selectedExcerciseId+"borderClass").classList.remove("select-border");
		}
	}
	  document.getElementById('sortable').innerHTML=str;//printing the elements in the specified id
  }
  /*method to change the category to retrieve the file based upon the category name*/
  function changeCategoryName(category){
	/*adding and removing the category style based on the conditions*/
		document.getElementById(currentCategory+"id").classList.remove("active");
		document.getElementById(currentCategory+"id").classList.add("zone");
		document.getElementById(category+"id").classList.add("active");
		document.getElementById(currentCategory+"id").classList.remove("zone");
		currentCategory = category;
		selectedCategory=category;
		
		
	/*using the ajax to hit the url and get the filelist*/
	  $.ajax({
	        url:"/selectExerciseAjax",
	        method:"POST", 

	        data:{
	        	category: category, 
	        },
	        success:function(response) {
	         var responseArray=response;
	         var str='',path='';
	         for(var i=0;i<responseArray.length;i++){
	        	 path="../../exercises/"+category.toLowerCase()+"/"+responseArray[i];
	       		 str+='<div class="col-md-3 mt-2 d-flex justify-content-center ml-5" id='+'"'+category+i+'borderClass"'+'  onclick="myFunction(this,'+"'"+category+i+"'"+','+"'"+responseArray[i].substring(0,responseArray[i].indexOf('.'))+"'"+','+"'"+path+"'"+','+"'"+category+"'"+')">'
                            +'<div class="card text-center mb-3 border-0 mt-3 card-color" >'+
                                '<div class="card-body">'
                                    +'<h5 class="card-title">'+responseArray[i].substring(0,responseArray[i].indexOf('.'))+'</h5>'
                                    +'<p class="card-text mt-4">'+
                                        '<video class="video-fluid z-depth-1" id='+'"'+category+i+'"'+'src='+'"'+path+'"'+' autoplay loop muted></video>'+
                                         '</p></div></div></div>';
               
               }
	         
	         document.getElementById('videofiles').innerHTML=str;//printing the elements in the specified id
	         for(var i=0;i<responseArray.length;i++){
	         	for(var j=0;j<array.length;j++){
	           	  if(array[j].id == category+i){
	           		  console.log(array[j].id);
	           		  document.getElementById(array[j].id+"borderClass").classList.add("select-border");
	           	  }
	             }
	         }
	        },
	       error:function(){
	        alert("error");
	       }

	      });
  }
  /*method to save the selectedExercise in database via ajax*/
  function saveSelectedExcercise(){
	  console.log("saveSelectedExercise");
	var selectedExcerciseArray = new Array();
	var sortableLinks = $("#sortable");
	/* $("#sortable").sortable(); */
	var linkOrderData = $("#sortable").sortable('toArray');
	console.log(linkOrderData);
	for(var i=0;i<linkOrderData.length;i++){
	  for(var j=0;j<array.length;j++){
		  if(linkOrderData[i] == array[j].id){
			  selectedExcerciseArray.push(array[j]); 
		  }
	  }
	}
/* 	console.log("selectedExcerciseArray",selectedExcerciseArray); */
	 $.ajax({
        url:"/saveSelectedExerciseAjax",
        method:"POST",
        data:{
        	selectedExcerciseArray: JSON.stringify(selectedExcerciseArray),
        },
        success:function(response) {
         alert("success");
       },
       error:function(){
        alert("error");
       }

      }); 
	
  }
  /*method to add the object in the array */
function addList(categoryId,objectName,objectPath,categoryName){
      var object={
		id : categoryId,
		exerciseName: objectName,
		url:objectPath,
	    category:categoryName
	  }
	  array.push(object);
	 console.log(object.id,object.exerciseName,object.url);
	  var str='';
	   for(var i=0;i<array.length;i++){
		   console.log(array[i].id,array[i].exerciseName,array[i].url);
		   str+= '<li class="card sortable-card white-text row" id="'+array[i].id+'" ><span style="margin-left: -10px" class="mt-2"><a onclick="removeSelectedExcercise('+"'"+array[i].id+"'"+','+"'"+array[i].category+"'"+')"><img src="img/exerciseMinus.svg" class="img-fluid mt-3"></a>'
     			+'</span><span class=" mt-3" style="z-t" ><p >'+array[i].exerciseName+'</p></span><span class="row mt-2" style="position: absolute;margin-left: 90px;"><p class="sortable-blur-text mr-4 " style="">'+i+'</p></span></li>';
       }
	   document.getElementById('sortable').innerHTML=str;
	  } 	
    function myFunction(a,id,name,path,category) {
        // alert("ram");
        // alert(allowedNumberOfExerciseToSelect);
        currentCategory = category;
        selectedCategory = category;       
     	console.log(currentCategory);
        
        
        var count = document.querySelectorAll(".select-border").length;
        if(count>=allowedNumberOfExerciseToSelect && !(a.classList.contains("select-border"))){
            alert("Sorry! you can select only "+allowedNumberOfExerciseToSelect+" Exercises");
        }
        else{
        	if(a.classList.contains("select-border")){
        	   a.classList.remove("select-border");
        	   removeSelectedExcercise(id,category);//removing the object
        	}else{
            	a.classList.add("select-border");
            	addList(id,name,path,category);//adding the object
        	}
        }
     /*    a.stopPropagation? a.stopPropagation() : a.cancelBubble = true; */
    }
    function success(id) {
        alert(id);
    }
    /*to make chest active*/
    function activeOnLoad(){
    	
     var count = document.querySelectorAll("active").length;
     console.log(${template.getTemplateId()});
      if(count == 0){
    	  currentCategory="Chest";
    	  document.getElementById("Chestid").classList.remove("zone");
    	  document.getElementById("Chestid").classList.add("active");
      }
    }
    
</script>

<%--Script to make selected exercise box re-arrangeble--%>
<script>
    $("#sortable").sortable();
</script>


<!-- Bootstrap tooltips -->
<script type="text/javascript" src="../../js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="../../js/mdb.min.js"></script>
</body>

</html>
