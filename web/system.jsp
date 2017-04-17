
<%@page import="model.Player.StringSystemData"%>
<%@page import="model.Player.SystemData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="model.Player.StringData" %>
<%@page language="java" import="model.Player.Logon" %>
<%@page language="java" import="dbUtils.DbConn" %>

<jsp:include page="jspIncludes/toHead.jsp" />

<style>
    .jumbo{
        position: relative;
        margin-top: 50px;
    }

    .jumbo h1 {
        color: black;
        font-size: 70px;  
        font-family: 'Lato', sans-serif;
        font-weight: bold;
        text-align: left;
        /*-webkit-text-stroke-width: 2px;
        -webkit-text-stroke-color: black;*/
    }

    .jumbo .container p{
        font-size: 20px;
    }

    #selectTagWrap{
        padding: 20px;
        float: left;
        /*width: 310px;*/    
        border-radius: 25px;
        text-align: center;
        opacity: 0.84;
        background-color: #efefef;
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

<!-- ALL JSP AND JAVASCRIPT CODE IS BELOW THE HTML-->

<jsp:include page="jspIncludes/headToContent.jsp" />


<%
    String msg = ""; //overrall message

    StringData loggedOnUser = (StringData) session.getAttribute("user"); //gets object/attribute set from logon.jsp
    //StringData loggedOnUser = new StringData();
    //loggedOnUser.userId = "17";
    //String systemId = "6";

    if (loggedOnUser == null) { //meaning user is not logged in
        try {
            // Will send user to deny.jsp page if not logged in 
            response.sendRedirect("deny.jsp?denyMsg=Log on to view your system's diagnostics.");
            //response.sendRedirect("chart.jsp");
        } catch (Exception e) {
            msg += " Exception was thrown: " + e.getMessage();
        }

    } else { //user is logged in 

        DbConn dbc = new DbConn(); //get database connection    

        if (request.getParameter("system_id") != null) {
            loggedOnUser.system_ip = request.getParameter("system_id");
            //session.setAttribute("user", loggedOnUser);
        }

        //get sytems
        String systems[] = SystemData.getSystems(dbc, loggedOnUser.userId);

        String selected = "selected = 'selected'";
        String outt = "\n\n<select name = 'system_id'>\n";

        //puts a pre-selected choice on first rendering of dropdown            
        outt += "   <option value = '0'>";
        outt += "Select Your System" + "</option>\n";

        //while there are more rows/records (ex. jedrick, david, john, etc.)
        for (int o = 0; o < systems.length; o++) {

            outt += "   <option value = '" + systems[o] + "'>";
            outt += systems[o] + "</option>\n";

        }

        outt += "</select>\n\n";
%>




<div class="jumbo">
    <div class="container">
        <h1>YOUR <br> SYSTEM</h1>
        <h4><a href="arduino.jsp?system_id=<%out.print(loggedOnUser.system_ip);%>">Click Here to Control<br> Your Aeroponics System</a></h4>
        <h4><a href="addSystem.jsp">Or Add a New System</a></h4>
        
        <h5><a href="systemLog.jsp?system_id=<%out.print(loggedOnUser.system_ip);%>">View System Log</a></h5>

        <div id="selectTagWrap">
            <form action="system.jsp" method="get">


                <span id="selectTag"><%out.print(outt);%></span>
                &nbsp;&nbsp;

                <input type="submit" value="View"/>
            </form>
        </div>

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

<!--
<div id="water">
    <canvas id="waterChart" width="50" height="20" ></canvas>
</div>

<div id="waterInfo">
    <h1>Water Level</h1>
    <p>The water temperature is normally reflective of the air temperature in the system. 
        The best way to control the water and air temperature is to keep your system in a 
        well controlled area.</p> 
</div>

-->
<div id="light">
    <canvas id="lightChart" width="50" height="20" ></canvas>
</div>

<div id="lightInfo">
    <h1>Light </h1>
    <p>Here you can control whether your system light is on or off. This chart simply
        shows the status of your light.</p> 
</div> 

<script>

    <%

        //put data from DB into sysData
        StringSystemData sysData[] = SystemData.retrieve(dbc, loggedOnUser.userId, loggedOnUser.system_ip);

        //StringSystemData sysData = SystemData.retrieve(dbc, loggedOnUser.userId);

        /* MAKE THE SELECTOR */
        //String roleSelect = MakeSelectTag.makeSelect(dbc, "roleName", roleSQL, input.roleName, "Select Role Name", "user_role_id", "role_name");
        //initialize separate arrays for each sensor
        int sslh_id[] = new int[sysData.length];
        float air_temp[] = new float[sysData.length],
                water_temp[] = new float[sysData.length],
                humidity[] = new float[sysData.length];
        int water_level[] = new int[sysData.length];
        boolean light_on_off[] = new boolean[sysData.length];
        String date_logged[] = new String[sysData.length];
        int system_id[] = new int[sysData.length];

        //fill initialized  arrays with the data from DB
        int counter;
        for (counter = 0; counter < sysData.length; counter++) {
            sslh_id[counter] = Integer.parseInt(sysData[counter].system_status_log_hourly_id);
            air_temp[counter] = Float.parseFloat(sysData[counter].air_temp);
            water_temp[counter] = Float.parseFloat(sysData[counter].water_temp);
            humidity[counter] = Float.parseFloat(sysData[counter].humidity);
            water_level[counter] = Integer.parseInt(sysData[counter].water_level);
            light_on_off[counter] = Boolean.parseBoolean(sysData[counter].light_on_off);
            date_logged[counter] = sysData[counter].date_logged;
            system_id[counter] = Integer.parseInt(sysData[counter].system_id);
        }
        counter = 0;

    %>






    //initializing all DB data arrays
    var dbAirTempData = [];
    var dbWaterTempData = [];
    var dbHumidityData = [];
    var dbWaterLevelData = [];
    var dbLightData = false;

    //PUTS JAVA ARRAY INTO JAVASCRIPT ARRAY

    //for airTempData
    <%for (int jk = 0; jk < sysData.length; jk++) {%>
    dbAirTempData.push("<%=air_temp[jk]%>");
    <%}%>

    //for waterTempData
    <%for (int jk = 0; jk < sysData.length; jk++) {%>
    dbWaterTempData.push("<%=water_temp[jk]%>");
    <%}%>

    //for humidityData
    <%for (int jk = 0; jk < sysData.length; jk++) {%>
    dbHumidityData.push("<%=humidity[jk]%>");
    <%}%>

    //for light data
    <%for (int jk = 0; jk < sysData.length; jk++) {%>
    dbLightData = ("<%=light_on_off[jk]%>");
    <%}%>


    //alert("air_temp: " + dbAirTempData);

    var sensorHighDataCollected = [1, 0, -1, -1], sensorMedDataCollected = [1, 1, -1, -1], sensorLowDataCollected = [1, 1, -1, -1];

    //HARDCODED VALUES FOR TESTING CHART 
    //var dbAirTempData = [69.0];
    //var dbWaterTempData = [66, 55];
    //var dbHumidityData = [0.6, 0.7];





    //AIR TEMPERATURE


    var hoursCollected = "<%=sysData.length%>";
    var hourLabels = [];

    for (var j = 0; j < hoursCollected; j++) {
        hourLabels[j] = (j + 1) + ":00";
    }


    var airTempData = {
        labels: hourLabels,
        datasets: [{
                label: 'Air Temperature',
                data: dbAirTempData,
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
                            labelString: 'Hours'
                        }
                    }]

            }
        }

    });



    //WATER TEMPERATURE

    var waterTempData = {
        labels: hourLabels,
        datasets: [{
                label: 'Water Temperature',
                data: dbWaterTempData,
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
                            labelString: 'Hours'
                        }
                    }]

            }
        }

    });


    //HUMIDITY 

    var humidityData = {
        labels: hourLabels,
        datasets: [{
                label: 'Humidity',
                data: dbHumidityData,
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
                            labelString: 'Hours'
                        }
                    }]

            }
        }

    });


    //WATER LEVEL

    /*
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
     */
    var lightData = [1];
    var backgroundColour = ["rgba(244, 48, 48, 0.75)"];
    var labelz = ["Off"];


    if (dbLightData) {
        backgroundColour = ["rgba(50, 242, 111, 0.75)"];
        labelz = ["On"];
    }


    var lightData = {
        labels: labelz,
        datasets: [{
                label: 'Light Bulb',
                data: lightData,
                backgroundColor: backgroundColour
            }]

    };

    var ctx5 = document.getElementById('lightChart').getContext('2d');
    var lightChart = new Chart(ctx5, {
        type: 'doughnut',
        data: lightData

    });






    //FOR CLOSING THE ELSE STATEMENT -- MEANING USER IS LOGGED IN
    <% 
        }%>

</script>




<jsp:include page="jspIncludes/postContent.jsp"/>