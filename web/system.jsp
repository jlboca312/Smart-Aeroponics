
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="model.Player.StringData" %>
<%@page language="java" import="model.Player.Logon" %>
<%@page language="java" import="dbUtils.DbConn" %>

<jsp:include page="jspIncludes/toHead.jsp" />



<%
    String msg = ""; //overrall message

    StringData loggedOnPlayer = (StringData) session.getAttribute("player"); //gets object/attribute set from logon.jsp

    if (loggedOnPlayer == null) { //meaning user is not logged in
        try {
            /* Will send user to deny.jsp page if not logged in */
            response.sendRedirect("deny.jsp?denyMsg=Log on to view your system's diagnostics.");
        } catch (Exception e) {
            msg += " Exception was thrown: " + e.getMessage();
        }

    }
%>

<jsp:include page="jspIncludes/headToContent.jsp" />


<div class="jumbo">
    <div class="container">
        <h1>YOUR <br> SYSTEM</h1>
        <p><a href="users.jsp">Click here to view table of users.</a></p>
      
    </div>
</div>

<jsp:include page="jspIncludes/postContent.jsp"/>