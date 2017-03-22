<%@page import="dbUtils.MakeSelectTag"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="view.WebOtherView" %>
<%@page language="java" import="dbUtils.DbConn" %>
<%@page language="java" import="model.Player.*" %>
<%@page language="java" import="dbUtils.DbConn" %>

<!-- JSP INCLUDES -->

<jsp:include page="jspIncludes/toHead.jsp"/>

<style>
    
</style>

<%
    /* GLOBAL VARIABLES */
    DbConn dbc = new DbConn(); //get database connection
    StringData input = new StringData();
    StringData errors = new StringData();
    
    String selectorErr = "";
    
    //variable for role_name select tag
    String roleSQL = "SELECT user_role_id, role_name FROM User_role ORDER BY role_name";

    if (request.getParameter("playerName") != null) {
        /* PLAYER STRING DATA*/
        input.playerName = request.getParameter("playerName");
        input.emailAddress = request.getParameter("emailAddress");
        input.pswd = request.getParameter("pswd");
        input.skillLevel = request.getParameter("skillLevel");
        input.roleName = request.getParameter("roleName");

        errors.errorMsg = dbc.getErr();
        
        if(input.roleName.equals("0")){
            selectorErr = "Must Select a Role Name";
        }
        
        if ((errors.errorMsg.length() == 0)) { //if no error message so database connection is good
            
            errors = DbMods.insert(input, dbc);
            
            if(errors.errorMsg.length() == 0){ //insert method returned empty string so SUCCESS!!
                errors.errorMsg = "Record successfully inserted!";
            }
        
        }
      
    }
    
    /* MAKE THE SELECTOR */
    String roleSelect = MakeSelectTag.makeSelect(dbc, "roleName", roleSQL, input.roleName, "Select Role Name", "user_role_id", "role_name");

    dbc.close(); //close db connection
%>

<jsp:include page="jspIncludes/headToContent.jsp"/>

<!-- START  OF CONTENT -->

<div class ="insert">
    <h1>Insert Player</h1>
    <form action="insertUsers.jsp" method="get">

        <div class = "insideInsert">
            Player Name
            <input type="text" name="playerName" value = "<%out.print(input.playerName);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.playerName);%></span>
            <br/>
            
            Email Address
            <input type = "text" name ="emailAddress" value = "<%out.print(input.emailAddress);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.emailAddress);%></span>
            <br/>
            
            Password
            <input type = "password" name="pswd" value = "<%out.print(input.pswd);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.pswd);%></span>
            <br/>
            
            Skill Level
            <input type = "text" name="skillLevel" value = "<%out.print(input.skillLevel);%>"/>
            <br/><br/>
            <br/>
                        
            Role Name 
            <span id="selectTag"><%out.print(roleSelect);%></span>
            <br/><br/>
            <span class ="error"><%out.print(selectorErr);%></span>
            

            <br/><br/>
        </div>

        <input type="submit" value="Submit"/>
        <br/><br/>

        <strong><%out.print(errors.errorMsg);%></strong>
        <br/>
        Click <a href = "users.jsp">here</a> to go back to player list

    </form>
</div>

        
<!-- JSP INCLUDE FOR FOOTER -->
<jsp:include page="jspIncludes/postContent.jsp"/>