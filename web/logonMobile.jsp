

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="model.Player.StringData" %>
<%@page language="java" import="model.Player.Logon" %>
<%@page language="java" import="dbUtils.DbConn" %>

<style>
    .logon{        
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
    String strPassword = "";
    String userNameErrorMsg = ""; // be optimistic
    String passwordErrorMsg = ""; // dont show an error upon 1st rendering
    String connErrorMsg = ""; //error message for connection failure
    String welcomeMsg = ""; //message to welcome user if logon successful
    String msg = ""; // this is an overall messsage (beyond field level validation)
    boolean success = false; //variable to state whether log on was successful or not

    
    if (request.getParameter("user_name") != null) {
        strUserName = request.getParameter("user_name"); //extract user input from URL
        if (strUserName.length() == 0) {
            userNameErrorMsg = "User Name is a required field";
        }
        strPassword = request.getParameter("password"); //extract user input from URL
        if (strPassword.length() == 0) {
            passwordErrorMsg = "Password is a required field";
        }

        
        
        DbConn dbc = new DbConn(); //get database connection

        if (connErrorMsg.length() == 0) { // no error message so database connection OK
            StringData loggedOnUser = Logon.find(dbc, strUserName, strPassword);
            
           
            
            if (loggedOnUser != null) {
                loggedOnUser.system_ip = Logon.findFirstSystem(dbc, loggedOnUser.userId);         
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

<jsp:include page="jspIncludes/headToContentMobile.jsp" />

<br><br>
<div class="logon">
    <h1>Login</h1>
    <form action="logonMobile.jsp" method="post">

        <div class = "insideLogon">
            Please enter your Username 
            <input name="user_name" value="<%out.print(strUserName);%>"/>
            <br/>
            <span class="error"><%=userNameErrorMsg%></span>
            <br/> <br/>
            Please enter your Password 
            <input name ="password" type = "password" value="<%out.print(strPassword);%>"/>
            <br/>
            <span class="error"><%=passwordErrorMsg%></span>
            <br/><br/>
        </div>

        <input type="submit" value="Log On"/>
        
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

