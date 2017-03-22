

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="model.Player.StringData" %>
<%@page language="java" import="model.Player.Logon" %>
<%@page language="java" import="dbUtils.DbConn" %>

<style>
    .logon{
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
    
    .logon .insideLogon input{
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

    String strEmail = "";
    String strPswd = "";
    String emailErrorMsg = ""; // be optimistic
    String pswdErrorMsg = ""; // dont show an error upon 1st rendering
    String connErrorMsg = ""; //error message for connection failure
    String welcomeMsg = ""; //message to welcome user if logon successful
    String msg = ""; // this is an overall messsage (beyond field level validation)
    boolean success = false; //variable to state whether log on was successful or not

    if (request.getParameter("emailAddress") != null) {
        strEmail = request.getParameter("emailAddress"); //extract user input from URL
        if (strEmail.length() == 0) {
            emailErrorMsg = "Email Address is a required field";
        }
        strPswd = request.getParameter("pswd"); //extract user input from URL
        if (strPswd.length() == 0) {
            pswdErrorMsg = "Password is a required field";
        }

        DbConn dbc = new DbConn(); //get database connection

        if (connErrorMsg.length() == 0) { // no error message so database connection OK
            StringData loggedOnPlayer = Logon.find(dbc, strEmail, strPswd);

            if (loggedOnPlayer != null) {
                session.setAttribute("player", loggedOnPlayer);
                success = true;
            }

            if (success) {
                welcomeMsg = "Log In Successful, Welcome " + loggedOnPlayer.playerName + " !";
            } else {
                welcomeMsg = "Log In Failed. Username and Password invalid.";
            }
        }
    }

%>

<jsp:include page="jspIncludes/headToContent.jsp" />

<div class="logon">
    <h1>Login</h1>
    <form action="logon.jsp" method="get">

        <div class = "insideLogon">
            Please enter your Email Address 
            <input name="emailAddress" value="<%out.print(strEmail);%>"/>
            <br/>
            <span class="error"><%=emailErrorMsg%></span>
            <br/> <br/>
            Please enter your Password 
            <input name ="pswd" type = "password" value="<%out.print(strPswd);%>"/>
            <br/>
            <span class="error"><%=pswdErrorMsg%></span>
            <br/><br/>
        </div>

        <input type="submit" value="Submit"/>
        
        <div id="RegisterMsg">
            <br/>
            <p>Don't have an account? Create one <a href="register.jsp">here.</a></p>
        </div>
        
        <span class="msg">
            <% out.print(msg);%>
        </span>
        <span class = "msg">
            <% out.print(welcomeMsg);%>
        </span>
    </form>


</div>


<jsp:include page="jspIncludes/postContent.jsp"/>
