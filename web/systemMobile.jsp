
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="model.Player.StringData" %>
<%@page language="java" import="model.Player.Logon" %>
<%@page language="java" import="dbUtils.DbConn" %>

<style>
    
    .jumbo{
        position: relative;
        margin-top: 50px;
    }

    .jumbo h1 {
        color: black;
        font-size: 50px;  
        font-family: 'Lato', sans-serif;
        font-weight: bold;
        text-align: left;
        /*-webkit-text-stroke-width: 2px;
        -webkit-text-stroke-color: black;*/
    }

    #airTemp{
        width: 550px;
        height: 450px; 
        float: left;
        margin-left:120px;
        margin-top:15px;
    }

    #airTempInfo{
        padding: 20px;
        margin-right:200px;
        float:right;
        width: 310px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
    }

    #waterTemp{
        width: 550px;
        height: 450px; 
        float: right;
        margin-right:120px;
    }

    #waterTempInfo{
        padding: 20px;
        margin-left:200px;
        float:left;
        width: 350px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
    }

    #humidity{
        width: 550px;
        height: 450px; 
        float: left;
        margin-left:120px;
        margin-top:15px;
    }

    #humidityInfo{
        padding: 20px;
        margin-right:200px;
        float:right;
        width: 310px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
    }

    #water{     
        width: 550px;
        height: 450px; 
        float: right;
        margin-right:120px;
    }

    #waterInfo{
        padding: 20px;
        margin-left:200px;
        float:left;
        width: 300px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
    }

    #light{     
        width: 550px;
        height: 450px; 
        float: left;
        margin-left:120px;
    }

    #lightInfo{
        padding: 20px;
        margin-right:200px;
        float:right;
        width: 300px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
    }

</style>


<%
    /*String msg = ""; //overrall message

    StringData loggedOnPlayer = (StringData) session.getAttribute("player"); //gets object/attribute set from logon.jsp

    if (loggedOnPlayer == null) { //meaning user is not logged in
        try {
            //Will send user to deny.jsp page if not logged in 
            response.sendRedirect("denyMobile.jsp?denyMsg=Log on to view your system's diagnostics.");
        } catch (Exception e) {
            msg += " Exception was thrown: " + e.getMessage();
        }

    }*/
%>

<jsp:include page="headToContentMobile.jsp" />

<<div class="jumbo">
    <div class="container">
        <h1>YOUR <br> SYSTEM</h1>
        <p><a href="users.jsp">Click here to view table of users.</a></p>

    </div>
</div>

<br><br><br>


<div id="airTemp">

    <canvas id="airTempChart" width="50" height="20" ></canvas>


</div>

<div id="airTempInfo">
    <h1>Air Temperature</h1>
    <p>This chart displays the past seven days of air temperature collection
        for your aeroponics system. You can observe all information about the data 
        from the chart. Ideally, you want your plant's air temperature to be 69 degrees. </p> 
</div>


<div id="waterTemp">

    <canvas id="waterTempChart" width="50" height="20" ></canvas>


</div>

<div id="waterTempInfo">
    <h1>Water Temperature</h1>
    <p>Here, you can see the past seven days of water temperature collection. To
        best simulate plants growing in nature, you want you water to be that of rain water,
        which is 45 degrees.</p> 
</div>


<div id="humidity">

    <canvas id="humidityChart" width="50" height="20" ></canvas>


</div>

<div id="humidityInfo">
    <h1>Humidity</h1>
    <p>The humidity of your aeroponics system is also collected every seven days and displayed here. 
    Since your system is regularly sprayed with nutrient rich water, the humidity is going to be generally high...
    unless you're growing cacti!</p> 
</div>


<div id="water">
    <canvas id="waterChart" width="50" height="20" ></canvas>
</div>

<div id="waterInfo">
    <h1>Water Level</h1>
    <p>The water temperature is normally reflective of the air temperature in the system. 
    The best way to control the water and air temperature is to keep your system in a 
    well controlled area.</p> 
</div>

<div id="light">
    <canvas id="lightChart" width="50" height="20" ></canvas>
</div>

<div id="lightInfo">
    <h1>Light </h1>
    <p>Here you can control whether your system light is on or off. This chart simply
    shows the status of your light.</p> 
</div>
<script>

    var ctx = document.getElementById('airTempChart').getContext('2d');
    var airTempChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                    label: 'Air Temperature',
                    data: [60, 63, 55, 71, 70, 68, 69],
                    backgroundColor: "rgba(3, 178, 39,0.75)"
                }]

        }, options: {
            scales: {
                yAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Temperature (°F)'
                        }
                    }],
                xAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Days of the Week'
                        }
                    }]

            }
        }

    });

    var ctx2 = document.getElementById('waterTempChart').getContext('2d');
    var waterTempChart = new Chart(ctx2, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                    label: 'Water Temperature',
                    data: [60, 63, 55, 71, 70, 68, 69],
                    backgroundColor: "rgba(66,240,244,0.75)"
                }]

        }, options: {
            scales: {
                yAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Temperature (°F)'
                        }
                    }],
                xAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Days of the Week'
                        }
                    }]

            }
        }

    });



    var ctx3 = document.getElementById('humidityChart').getContext('2d');
    var humidityChart = new Chart(ctx3, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                    label: 'Humidity',
                    data: [60, 63, 55, 71, 70, 68, 69],
                    backgroundColor: "rgba(255, 255, 102,0.75)"
                }]

        }, options: {
            scales: {
                yAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Percentage (%)'
                        }
                    }],
                xAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Days of the Week'
                        }
                    }]

            }
        }

    });


    var ctx4 = document.getElementById('waterChart').getContext('2d');
    var waterChart = new Chart(ctx4, {
        type: 'line',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [{
                    label: 'Water Level',
                    data: [7, 7, 6, 6, 5, 5, 4],
                    backgroundColor: "rgba(0,71,171,0.75)"
                }]

        }, options: {
            scales: {
                yAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Centimeters (cm)'
                        }
                    }],
                xAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Days of the Week'
                        }
                    }]

            }
        }

    });


    var ctx5 = document.getElementById('lightChart').getContext('2d');
    var lightChart = new Chart(ctx5, {
        type: 'doughnut',
        data: {
            labels: ["On", "Off"],
            datasets: [{
                    label: 'Light Bulb',
                    data: [1, 1],
                    backgroundColor: ["rgba(50, 242, 111, 0.75)", "rgba(244, 48, 48, 0.75)"]
                }]

        }

    });


</script>

<jsp:include page="jspIncludes/postContent.jsp"/>