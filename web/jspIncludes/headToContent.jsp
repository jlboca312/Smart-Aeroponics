
</head>


<body>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>

    <%@page language="java" import="model.Player.StringData" %>
    <%@page language="java" import="model.Player.Logon" %>
    <%@page language="java" import="dbUtils.DbConn" %>

    <%
        String logonLink = "";
        String msg = ""; //overrall message

        StringData loggedOnPlayer = (StringData) session.getAttribute("player"); //gets object/attribute set from logon.jsp

        if (loggedOnPlayer == null) { //meaning user is not logged in
            try {
                msg = "";
                logonLink = "<span id=\"logg\"><a href ='logon.jsp'>LOG ON</a></span>"; //show a Log On link if no user is logged in
            } catch (Exception e) {
                msg += " Exception was thrown: " + e.getMessage();
            }

        } else { //meaning user is logged in
            try {
                msg = "Welcome " + loggedOnPlayer.playerName + "!";
                logonLink = "<span id=\"logg\"><a href = 'logoff.jsp'>Log Off</a></span>"; //show log of link if user is logged in, brings them to logoff.jsp
            } catch (Exception e) {
                msg += " Exception was thrown: " + e.getMessage();
            }
        }
    %>





    <div id="title">
        <div id="nav">
            <div class="pageTitle">
                <%out.print(msg);%>

                &nbsp;

                <%out.print(logonLink);%>

            </div>



            <div id="navBar">
                <a href="index.jsp">HOME</a>  &nbsp;&nbsp; | &nbsp;&nbsp;  
                <a href="users.jsp">SYSTEM DIAGNOSTICS</a> &nbsp;&nbsp; | &nbsp;&nbsp;
                <a href="about.jsp">ABOUT</a> &nbsp;&nbsp; | &nbsp;&nbsp;
                <a href="contact.jsp">CONTACT US</a> 

            </div>
            <span class="stopFloat"></span>
        </div>
    </div>

    <div id="content">



