<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="view.WebOtherView" %>
<%@page language="java" import="dbUtils.DbConn" %>
<%@page language="java" import="model.Player.*" %>
<%@page language="java" import="dbUtils.DbConn" %>
<%@page language="java" import="view.WebUserView" %>
<%@page import="dbUtils.MakeSelectTag"%>

<style>
    .resultSetFormat th {
        /*border: thin solid black; */
        /*background-color:#999999; */
        background-color: #636382;
        padding:5px;
        opacity: 0.84;      
        color: white;
    }

    .resultSetFormat td {
        /*border: thin solid black; */
        background-color:#efefef; 
        padding:5px;
        opacity: 0.84;       
    }

    .resultSetFormat tr{
        color: black;       
    }

    table {
        margin:auto;
        position: relative;
        right: 50px;
    }

    h1, h2 {
        text-align:center;
    }

    #SystemTable h2{  
        margin-top:60px;
        color: white;
        letter-spacing: 1px;
        font-family: 'Lato', sans-serif;
    }

    #SystemTable{
        height: 590px; /*allows for the footer to be at bottom of page*/
        margin: auto;
    }




</style>

<%  String msg = "";
    String successMsg = "";
    DbConn dbc = new DbConn();
    msg = dbc.getErr(); // returns "" if connection is good, else error msg.
    if (msg.length() == 0) { // got open connection

        String systemId = "";
        if (request.getParameter("system_id") != null) {
            systemId = request.getParameter("system_id");
            //session.setAttribute("user", loggedOnUser);
        }

        // returns a string that contains a HTML table with the db data in it
        msg = WebUserView.listAllUser("resultSetFormat", dbc, systemId); //old without the update icon

    }
    // PREVENT DB connection leaks:
    dbc.close(); //    EVERY code path that opens a db connection, must also close it.
%>

<jsp:include page="jspIncludes/headToContent.jsp" />

<div id = "SystemTable">

    <h2>PLAYER LIST</h2>
    <br/>

    <% out.print(msg);%>


</div>

<jsp:include page="jspIncludes/postContent.jsp"/>