

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

    String strUserName = "";
    String strSalt = "";
    String userNameErrorMsg = ""; // be optimistic
    String saltErrorMsg = ""; // dont show an error upon 1st rendering
    String connErrorMsg = ""; //error message for connection failure
    String welcomeMsg = ""; //message to welcome user if logon successful
    String msg = ""; // this is an overall messsage (beyond field level validation)
    boolean success = false; //variable to state whether log on was successful or not

    if (request.getParameter("user_name") != null) {
        strUserName = request.getParameter("user_name"); //extract user input from URL
        if (strUserName.length() == 0) {
            userNameErrorMsg = "User Name is a required field";
        }
        strSalt = request.getParameter("salt"); //extract user input from URL
        if (strSalt.length() == 0) {
            saltErrorMsg = "Salt is a required field";
        }

        
        
        DbConn dbc = new DbConn(); //get database connection

        if (connErrorMsg.length() == 0) { // no error message so database connection OK
            StringData loggedOnUser = Logon.find(dbc, strUserName, strSalt);

            
            if (loggedOnUser != null) {
                session.setAttribute("user", loggedOnUser);
                success = true;
            }

            if (success && (loggedOnUser.user_name.length() > 0)) {
                welcomeMsg = "Log In Successful, Welcome " + loggedOnUser.user_name + "!";
            } else {
                welcomeMsg = "Log In Failed. Username and Password invalid.";
            }
        }
    }

%>

<jsp:include page="jspIncludes/headToContent.jsp" />

<div class="logon">
    <h1>Login</h1>
    <form action="logon.jsp" method="post">

        <div class = "insideLogon">
            Please enter your Username 
            <input name="user_name" value="<%out.print(strUserName);%>"/>
            <br/>
            <span class="error"><%=userNameErrorMsg%></span>
            <br/> <br/>
            Please enter your Password 
            <input name ="salt" type = "password" value="<%out.print(strSalt);%>"/>
            <br/>
            <span class="error"><%=saltErrorMsg%></span>
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
