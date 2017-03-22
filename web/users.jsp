<%@page import="model.Player.DbMods"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page language="java" import="view.WebUserView" %>
<%@page language="java" import="dbUtils.DbConn" %>

<!-- JSP INCLUDES -->

<jsp:include page="jspIncludes/toHead.jsp"/>

<style>

    .resultSetFormat th {
        /*border: thin solid black; */
        /*background-color:#999999; */
        background-color: #636382;
        padding:5px;
        opacity: 0.84;      
        color: white;
    }

    .resultSetFormat td {
        /*border: thin solid black; */
        background-color:#efefef; 
        padding:5px;
        opacity: 0.84;       
    }

    .resultSetFormat tr{
        color: black;       
    }

    table {
        margin:auto;
        position: relative;
        right: 50px;
    }

    h1, h2 {
        text-align:center;
    }

    #PlayerTable h2{  
        margin-top:60px;
        color: white;
        letter-spacing: 1px;
        font-family: 'Lato', sans-serif;
    }

    #PlayerTable{
        height: 590px; /*allows for the footer to be at bottom of page*/
        margin: auto;
    }

    #userInsert a{
        text-decoration: none;
        font-size: 16px;
    }

    #userInsert{
        position: absolute;
        left: 415px;
        top: 96px;
        font-family: 'Lato', sans-serif;
    }
    
    #successMessage{
        background-color: #efefef;
        border-radius: 5px;
        margin: auto;
        padding: auto;
        opacity: 0.84;
        text-align: center;
        width: 300px;
        position: relative;
        top: 20px;
        font-weight: bold;
        right: 50px; 
    }
</style>


<%  String msg = "";
    String successMsg = "";
    DbConn dbc = new DbConn();
    msg = dbc.getErr(); // returns "" if connection is good, else error msg.
    if (msg.length() == 0) { // got open connection

        String primaryKey = request.getParameter("webUserPK");

        if (primaryKey != null && primaryKey.length() != 0) {  // they want to delete a record

            //call the delete method
            successMsg = DbMods.delete(primaryKey, dbc);
        }

        // returns a string that contains a HTML table with the db data in it
        //msg = WebUserView.listAllUser("resultSetFormat", dbc); //old without the update icon
        msg = WebUserView.playerListUpdate("icons/delete.png", "javascript:deleteRow", "icons/update.png", "updateUser.jsp?playerId", "resultSetFormat", dbc);
    }
    // PREVENT DB connection leaks:
    dbc.close(); //    EVERY code path that opens a db connection, must also close it.
%>

<jsp:include page="jspIncludes/headToContent.jsp"/>

<!-- START  OF CONTENT -->



<form name="deleteForm" action="users.jsp" method="get">
    <input type="text" name="webUserPK">
</form>


<div id = "PlayerTable">

    <h2>PLAYER LIST</h2>
    <br/>
    
    <div id="userInsert">
        <a href="insertUsers.jsp">Insert Player</a>
        <% out.print(msg);%>

        <div id="successMessage">
            <% out.print(successMsg);%>
        </div>
    </div>

</div>

<script language="Javascript" type="text/javascript">
    function deleteRow(userID) {
        if (confirm("Do you really want to delete player " + userID + "?")) {
            document.deleteForm.webUserPK.value = userID;
            document.deleteForm.submit();
        }
    }
</script>





<!-- JSP INCLUDE FOR FOOTER -->
<jsp:include page="jspIncludes/postContent.jsp"/>