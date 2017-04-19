<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="view.WebOtherView" %>
<%@page language="java" import="dbUtils.DbConn" %>
<%@page language="java" import="model.Player.*" %>
<%@page language="java" import="dbUtils.DbConn" %>
<%@page import="dbUtils.MakeSelectTag"%>

<style>
    .addSystem{
        margin-top: 60px;
        text-align: center;
        background-color: #efefef;
        width: 500px;
        margin: auto;
        margin-top: 80px;
        border-radius: 25px;
        padding-top: 10px;
        padding-bottom: 10px;
        opacity: 0.84;
    }

    .addSystem .insideAddSystem input{
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
    /* GLOBAL VARIABLES */
    DbConn dbc = new DbConn(); //get database connection
    StringData input = new StringData();
    StringData errors = new StringData();

    StringData loggedOnUser = (StringData) session.getAttribute("user"); //gets object/attribute set from logon.jsp
    String selectorErr = "";

    if (request.getParameter("system_ip") != null) {
        input.system_ip = request.getParameter("system_ip");

        errors.errorMsg = dbc.getErr();

        /*if (input.roleName.equals("0")) {
            selectorErr = "Must Select a Role Name";
        }*/

        if ((errors.errorMsg.length() == 0)) { //if no error message so database connection is good

            errors = DbMods.insertSystem(input, dbc, loggedOnUser.userId);

            if (errors.errorMsg.length() == 0) { //insert method returned empty string so SUCCESS!!
                errors.errorMsg = "Record successfully inserted!";
            }

        }

    }

    /* MAKE THE SELECTOR */
    //String roleSelect = MakeSelectTag.makeSelect(dbc, "roleName", roleSQL, input.roleName, "Select Role Name", "user_role_id", "role_name");

    dbc.close(); //close db connection
%>


<jsp:include page="jspIncludes/headToContent.jsp" />

<div class="addSystem">
    <h1>Add System</h1>
    <form action="addSystem.jsp" method="get">

        <div class = "insideAddSystem">
            <br/>
            System IP
            <!-- THE NAME ASPECT IN THE INPUT TAG MUST MATCH THE FIELD IN THE DATABASE -->
            <input type="text" name="system_ip" value = "<%out.print(input.system_ip);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.system_ip);%></span>
            <br/>


        </div>

        <input type="submit" value="Submit"/>

        <strong><%out.print(errors.errorMsg);%></strong>
        <br/>
    </form>

<jsp:include page="jspIncludes/postContent.jsp"/>