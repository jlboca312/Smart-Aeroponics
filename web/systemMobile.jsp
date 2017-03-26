
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="model.Player.StringData" %>
<%@page language="java" import="model.Player.Logon" %>
<%@page language="java" import="dbUtils.DbConn" %>

<style>
    .background{
        background-image:url('https://wallpaperscraft.com/image/sun_leaves_mint_plant_74320_360x640.jpg');
        top: 0;
        left: 0;
        background-size: cover;
        height: 100%;
        width:360px;
        background-attachment: fixed;
        
    }
</style>

<%
    String msg = ""; //overrall message

    StringData loggedOnPlayer = (StringData) session.getAttribute("player"); //gets object/attribute set from logon.jsp

    if (loggedOnPlayer == null) { //meaning user is not logged in
        try {
            /* Will send user to deny.jsp page if not logged in */
            response.sendRedirect("denyMobile.jsp?denyMsg=Log on to view your system's diagnostics.");
        } catch (Exception e) {
            msg += " Exception was thrown: " + e.getMessage();
        }

    }
%>

<jsp:include page="headToContentMobile.jsp" />

<div class="background">


    <div class="jumbo">
        <div class="container">
            <h1>YOUR <br> SYSTEM</h1>

        </div>
    </div>

</div>

<jsp:include page="jspIncludes/postContent.jsp"/>