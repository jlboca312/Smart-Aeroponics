<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />
<%@page language="java" import="dbUtils.DbConn" %>
<%@page language="java" import="model.Player.*" %>
<%@page language="java" import="dbUtils.DbConn" %>
<%@page import="dbUtils.MakeSelectTag"%>
<style>
    .register{
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

    .register .insideRegister input{
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
    /* GLOBAL VARIABLES */
    DbConn dbc = new DbConn(); //get database connection
    StringData input = new StringData();
    StringData errors = new StringData();

    String selectorErr = "";

    //variable for role_name select tag
    //String roleSQL = "SELECT user_role_id, role_name FROM User_role ORDER BY role_name";
    if (request.getParameter("user_name") != null) {
        /* PLAYER STRING DATA*/
        input.user_name = request.getParameter("user_name");
        input.email = request.getParameter("email");
        input.first_name = request.getParameter("first_name");
        input.last_name = request.getParameter("last_name");
        input.phone_number = request.getParameter("phone_number");
        input.password = request.getParameter("password");
        input.system_ip = request.getParameter("system_ip");

        errors.errorMsg = dbc.getErr();

        /*if (input.roleName.equals("0")) {
            selectorErr = "Must Select a Role Name";
        }*/

        if ((errors.errorMsg.length() == 0)) { //if no error message so database connection is good

            errors = DbMods.insert(input, dbc);

            if (errors.errorMsg.length() == 0) { //insert method returned empty string so SUCCESS!!
                errors.errorMsg = "Record successfully inserted!";
            }

        }

    }

    /* MAKE THE SELECTOR */
    //String roleSelect = MakeSelectTag.makeSelect(dbc, "roleName", roleSQL, input.roleName, "Select Role Name", "user_role_id", "role_name");

    dbc.close(); //close db connection
%>


<jsp:include page="jspIncludes/headToContent.jsp" />

<div class="register">
    <h1>Register</h1>
    <form action="register.jsp" method="get">

        <div class = "insideRegister">
            <br/>
            Username
            <!-- THE NAME ASPECT IN THE INPUT TAG MUST MATCH THE FIELD IN THE DATABASE -->
            <input type="text" name="user_name" value = "<%out.print(input.user_name);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.user_name);%></span>
            <br/>

            Email Address
            <input type = "text" name ="email" value = "<%out.print(input.email);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.email);%></span>
            <br/>

            First Name
            <input type = "text" name="first_name" value = "<%out.print(input.first_name);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.first_name);%></span>
            <br/>

            Last Name
            <input type = "text" name="last_name" value = "<%out.print(input.last_name);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.last_name);%></span>
            <br/>
            
            Phone Number
            <input type = "text" name="phone_number" value = "<%out.print(input.phone_number);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.phone_number);%></span>
            <br/>
            
            Password
            <input type = "text" name="password" value = "<%out.print(input.password);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.password);%></span>
            <br/>
            
            System IP
            <input type = "text" name="system_ip" value = "<%out.print(input.system_ip);%>"/>
            <br/><br/>
            <span class="error"><%out.print(errors.system_ip);%></span>
            <br/>
            


            <!--Role Name 
            <span id="selectTag"></span>
            <br/><br/>
            <span class ="error"></span>  -->

            <br/><br/>

        </div>

        <input type="submit" value="Submit"/>

        <strong><%out.print(errors.errorMsg);%></strong>
        <br/>
    </form>
</div>


<jsp:include page="jspIncludes/postContent.jsp"/>


