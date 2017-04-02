
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
        width: 350px;
        height: 200px; 
        margin: 0 auto;
        
    }

    #airTempInfo{
        
        position: relative;
        padding: 20px;
        width: 310px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
        margin: 0 auto;
        margin-bottom: 80px;
    }

    #waterTemp{
        width: 350px;
        height: 200px;
        margin: 0 auto;
    }

    #waterTempInfo{
        padding: 20px;
        margin-left:200px;
        width: 350px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
        margin: 0 auto;
        margin-bottom: 80px;
    }

    #humidity{
        width: 350px;
        height: 200px; 
        margin: 0 auto;
    }

    #humidityInfo{
        padding: 20px;
        margin-right:200px;
        width: 310px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
        margin: 0 auto;
        margin-bottom: 80px;
    }

    #water{     
        width: 350px;
        height: 200px;
        margin: 0 auto;
    }

    #waterInfo{
        padding: 20px;
        margin-left:200px;
        width: 300px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
        margin: 0 auto;
        margin-bottom: 80px;
    }

    #light{     
        width: 350px;
        height: 200px;
        margin: 0 auto;
    }

    #lightInfo{
        padding: 20px;
        margin-right:200px;
        width: 300px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
        margin: 0 auto;

    }

</style>


<%
    String msg = ""; //overrall message

    StringData loggedOnPlayer = (StringData) session.getAttribute("player"); //gets object/attribute set from logon.jsp

    if (loggedOnPlayer == null) { //meaning user is not logged in
        try {
            //Will send user to deny.jsp page if not logged in 
            response.sendRedirect("denyMobile.jsp?denyMsg=Log on to view your system's diagnostics.");
        } catch (Exception e) {
            msg += " Exception was thrown: " + e.getMessage();
        }

    }
%>

<jsp:include page="jspIncludes/headToContentMobile.jsp" />


<div class="jumbo">
    <div class="container">
        <h1>YOUR <br> SYSTEM</h1>
        <p><a href="users.jsp">Click here to view table of users.</a></p>

    </div>
</div>

<br><br><br>


<div id="airTemp">
    <canvas id="airTempChart" ></canvas>
</div>

<div id="airTempInfo">
    <h1>Air Temperature</h1>
    <p>This chart displays the past seven days of air temperature collection
        for your aeroponics system. You can observe all information about the data 
        from the chart. Ideally, you want your plant's air temperature to be 69 degrees. </p> 
</div>


<div id="waterTemp">

    <canvas id="waterTempChart"></canvas>


</div>

<div id="waterTempInfo">
    <h1>Water Temperature</h1>
    <p>Here, you can see the past seven days of water temperature collection. To
        best simulate plants growing in nature, you want you water to be that of rain water,
        which is 45 degrees.</p> 
</div>


<div id="humidity">

    <canvas id="humidityChart"></canvas>


</div>

<div id="humidityInfo">
    <h1>Humidity</h1>
    <p>The humidity of your aeroponics system is also collected every seven days and displayed here. 
        Since your system is regularly sprayed with nutrient rich water, the humidity is going to be generally high...
        unless you're growing cacti!</p> 
</div>


<div id="water">
    <canvas id="waterChart"></canvas>
</div>

<div id="waterInfo">
    <h1>Water Level</h1>
    <p>The water temperature is normally reflective of the air temperature in the system. 
        The best way to control the water and air temperature is to keep your system in a 
        well controlled area.</p> 
</div>

<div id="light">
    <canvas id="lightChart"></canvas>
</div>

<div id="lightInfo">
    <h1>Light </h1>
    <p>Here you can control whether your system light is on or off. This chart simply
        shows the status of your light.</p> 
</div>
<br><br><br>
<script>

    //AIR TEMPERATURE

    var dbAirTempData = [70, 71, -1, -1];
    var hoursCollected = 0;
    var airTempDataCollected = [];
    var hourLabels = [];

    for (hoursCollected; dbAirTempData[hoursCollected] !== -1; hoursCollected++) {
        airTempDataCollected[hoursCollected] = dbAirTempData[hoursCollected];
    }

    for (var i = 0; i < hoursCollected; i++) {
        hourLabels[i] = (i + 1) + ":00";
    }


    var airTempData = {
        labels: hourLabels,
        datasets: [{
                label: 'Air Temperature',
                data: airTempDataCollected,
                backgroundColor: "rgba(3, 178, 39,0.75)"
            }]

    };

    var ctx = document.getElementById('airTempChart').getContext('2d');
    var airTempChart = new Chart(ctx, {
        type: 'line',
        data: airTempData, options: {
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



    //WATER TEMPERATURE



    var dbWaterTempData = [70, 71, -1, -1];
    var waterTempDataCollected = [];
    var i = 0;

    for (i; i < hoursCollected; i++) {
        waterTempDataCollected[i] = dbWaterTempData[i];
    }


    var waterTempData = {
        labels: hourLabels,
        datasets: [{
                label: 'Water Temperature',
                data: waterTempDataCollected,
                backgroundColor: "rgba(66,240,244,0.75)"
            }]

    };

    var ctx2 = document.getElementById('waterTempChart').getContext('2d');
    var waterTempChart = new Chart(ctx2, {
        type: 'line',
        data: waterTempData, options: {
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


    //HUMIDITY 

    var dbHumidityTempData = [0.7, 0.71, -1, -1];
    var humidityDataCollected = [];
    i = 0;

    for (i; i < hoursCollected; i++) {
        humidityDataCollected[i] = dbHumidityTempData[i];
    }

    var humidityData = {
        labels: hourLabels,
        datasets: [{
                label: 'Humidity',
                data: humidityDataCollected,
                backgroundColor: "rgba(255, 255, 102,0.75)"
            }]

    };

    var ctx3 = document.getElementById('humidityChart').getContext('2d');
    var humidityChart = new Chart(ctx3, {
        type: 'line',
        data: humidityData, options: {
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


    //WATER LEVEL

    var sensorHighDataCollected = [1, 0, -1, -1], sensorMedDataCollected = [1, 1, -1, -1], sensorLowDataCollected = [1, 1, -1, -1];
    var floatSensorHighMapped = [], floatSensorMedMapped = [], floatSensorLowMapped = [], noWater = [];
    i = 0;

    for (i; i < hoursCollected; i++) {

        switch (sensorHighDataCollected[i]) {
            case 1:
                floatSensorHighMapped[i] = 3;
                break;
            case 0:
                floatSensorHighMapped[i] = 2;
                break;
        }

        switch (sensorMedDataCollected[i]) {
            case 1:
                floatSensorMedMapped[i] = 2;
                break;
            case 0:
                floatSensorMedMapped[i] = 1;
                break;
        }

        switch (sensorLowDataCollected[i]) {
            case 1:
                floatSensorLowMapped[i] = 1;
                break;
            case 0:
                floatSensorLowMapped[i] = 0;
                break;
        }
        
        noWater[i] = 0;
    }

    var waterLevelData = {
        labels: hourLabels,
        datasets: [{
                label: 'High',
                data: floatSensorHighMapped,
                backgroundColor: "rgba(0,71,171,0.75)"
            },
            {
                label: 'Medium',
                data: floatSensorMedMapped,
                backgroundColor: "rgba(0,71,171,0.75)"
            },
            {
                label: 'Low',
                data: floatSensorLowMapped,
                backgroundColor: "rgba(0,71,171,0.75)"
            },
            {
                label: '',
                data: noWater,
                backgroundColor: "rgba(0,71,171,0.75)"
            }]

    };

    var ctx4 = document.getElementById('waterChart').getContext('2d');
    var waterChart = new Chart(ctx4, {
        type: 'line',
        data: waterLevelData, options: {
            scales: {
                yAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Water Level'
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

    var lightData = {
        labels: ["On", "Off"],
        datasets: [{
                label: 'Light Bulb',
                data: [1, 1],
                backgroundColor: ["rgba(50, 242, 111, 0.75)", "rgba(244, 48, 48, 0.75)"]
            }]

    };

    var ctx5 = document.getElementById('lightChart').getContext('2d');
    var lightChart = new Chart(ctx5, {
        type: 'doughnut',
        data: lightData

    });



</script>

<jsp:include page="jspIncludes/postContent.jsp"/>