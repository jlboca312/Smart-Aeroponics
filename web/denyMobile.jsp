

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page language="java" import="model.Player.StringData" %>
<%@page language="java" import="model.Player.Logon" %>
<%@page language="java" import="dbUtils.DbConn" %>

<jsp:include page="jspIncludes/toHead.jsp" />

<style>

    .denyBox{
        width: 300px;
        padding:20px;
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
        border-bottom:1px solid #dbdbdb;
        margin: 0 auto;
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

<jsp:include page="jspIncludes/headToContentMobile.jsp" />

<br><br><br>

<div class = "denyBox">

    <h3>Sorry, you must be logged in!</h3>

    <br/>

    <div class = "denyMsg">
        <%out.print(msg);%>
        <br/>
    </div>
</div>


<jsp:include page="jspIncludes/postContent.jsp"/>
