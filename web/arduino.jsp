<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="view.WebOtherView" %>
<%@page language="java" import="dbUtils.DbConn" %>
<%@page language="java" import="model.Player.*" %>
<%@page language="java" import="dbUtils.DbConn" %>
<%@page import="dbUtils.MakeSelectTag"%>

<style>

    .arduino{
        margin-top: 60px;
        text-align: center;
        background-color: #efefef;
        width: 500px;
        margin: auto;
        margin-top: 80px;
        border-radius: 25px;
        padding-top: 1px;
        padding-bottom: 10px;
        opacity: 0.84;
    }

    .arduino .insideArduino input{
        display: inline-block;
        float:right;
        position: relative;
        right: 40px;
    }

    .error{
        color: red;
    }

    .msg{
        font-weight: bold;
        font-size: 16px;
    }
</style>

<%

    DbConn dbc = new DbConn(); //get database connection
    StringArduinoData input = new StringArduinoData();
    StringArduinoData errors = new StringArduinoData();

    if (request.getParameter("system_id") != null) {
        input.system_id = request.getParameter("system_id");

    }
//variable for role_name select tag
    //String roleSQL = "SELECT user_role_id, role_name FROM User_role ORDER BY role_name";
    if (request.getParameter("light_interval_start") != null) {
        /* PLAYER STRING DATA*/
        input.light_interval_start = request.getParameter("light_interval_start");
        input.light_interval = request.getParameter("light_interval");
        input.mist_interval_off = request.getParameter("mist_interval_off");
        input.mist_interval_on = request.getParameter("mist_interval_on");

        errors.errorMsg = dbc.getErr();

        /*if (input.roleName.equals("0")) {
            selectorErr = "Must Select a Role Name";
        }*/
        if ((errors.errorMsg.length() == 0)) { //if no error message so database connection is good

            errors = DbMods.send(input, input.system_id, dbc);

            if (errors.errorMsg.length() == 0) { //insert method returned empty string so SUCCESS!!
                errors.errorMsg = "Data Sent Successfully!";
            }

        }

    }

    /* MAKE THE SELECTOR */
    //String roleSelect = MakeSelectTag.makeSelect(dbc, "roleName", roleSQL, input.roleName, "Select Role Name", "user_role_id", "role_name");
    dbc.close(); //close db connection

    /*
    if (request.getParameter("light_interval_start") != null) {
        throw new Exception(input.system_id);
    }
     */
%>

<jsp:include page="jspIncludes/headToContent.jsp" />

<div class="arduino">
    <h1>Control Your Arduino</h1>
    <form action="arduino.jsp" method="get">

        <div class = "insideArduino">
            <br/>
            Artificial Sunrise
            <!-- THE NAME ASPECT IN THE INPUT TAG MUST MATCH THE FIELD IN THE DATABASE -->
            <input type="text" name="light_interval_start" value = "<%out.print(input.light_interval_start);%>"/>
            <br><span style="font-size: 10px;">(0-24):(0-59) Ex.16:30</span>
            <br/><br/>
            <span class="error"><%out.print(errors.light_interval_start);%></span>
            <br/>

            Day Length
            <input type = "text" name ="light_interval" value = "<%out.print(input.light_interval);%>"/>
            <br><span style="font-size: 10px;">(0-24) Ex. 8</span>
            <br/><br/>
            <span class="error"><%out.print(errors.light_interval);%></span>
            <br/>

            Mist Interval 
            <input type = "text" name="mist_interval_off" value = "<%out.print(input.mist_interval_off);%>"/>
            <br><span style="font-size: 10px;">(0-99):(0-59) Ex.2:00</span>
            <br/><br/>
            <span class="error"><%out.print(errors.mist_interval_off);%></span>
            <br/>

            Mist Interval Duration
            <input type = "text" name="mist_interval_on" value = "<%out.print(input.mist_interval_on);%>"/>
            <br><span style="font-size: 10px;">(0-59) Ex.16:30</span>
            <br/><br/>
            <span class="error"><%out.print(errors.mist_interval_on);%></span>
            <br/> 

            <input type = "hidden" name="system_id" value = "<%out.print(input.system_id);%>"/>

            <br/><br/>

        </div>

        <input type="submit" value="Submit"/>

        <strong><%out.print(errors.errorMsg);%></strong>
        <br/>
    </form>

    <jsp:include page="jspIncludes/postContent.jsp"/>