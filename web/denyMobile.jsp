

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page language="java" import="model.Player.StringData" %>
<%@page language="java" import="model.Player.Logon" %>
<%@page language="java" import="dbUtils.DbConn" %>

<jsp:include page="jspIncludes/toHead.jsp" />

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
    .denyBox{
        margin-top: 60px;
        text-align: center;
        background-color: #efefef;
        width: 500px;
        margin: auto;
        margin-top: 100px;
        border-radius: 25px;
        padding-top: 1px;
        padding-bottom: 10px;
        opacity: 0.84;
    }

    .denyMsg{
        font-size: 14px;
        position: relative;
        bottom: 10px;
    }

</style>

<%
    String msg = "";

    if (request.getParameter("denyMsg") != null) {
        msg = request.getParameter("denyMsg");
    }


%>

<jsp:include page="headToContentMobile.jsp" />

<div class="background">

    <div class = "denyBox">

        <h3>Sorry, you must be logged in!</h3>

        <br/>

        <div class = "denyMsg">
            <%out.print(msg);%>
            <br/>
        </div>
    </div>

</div>
<jsp:include page="jspIncludes/postContent.jsp"/>
