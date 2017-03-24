

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page language="java" import="model.Player.StringData" %>
<%@page language="java" import="model.Player.Logon" %>
<%@page language="java" import="dbUtils.DbConn" %>

<jsp:include page="jspIncludes/toHead.jsp" />

<style>
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

<jsp:include page="jspIncludes/headToContent.jsp" />

<div class = "denyBox">

    <h3>Sorry, you must be logged in!</h3>
    
    <br/>

    <div class = "denyMsg">
        <%out.print(msg);%>
        <br/>
    </div>
</div>

<jsp:include page="jspIncludes/postContent.jsp"/>
