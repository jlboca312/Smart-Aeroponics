<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' /> <!-- SO USER CANT ZOOM OUT-->
</head>


<body>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    
    <!-- More Bootsrap Jquery stuff -->
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>

    <%@page language="java" import="model.Player.StringData" %>
    <%@page language="java" import="model.Player.Logon" %>
    <%@page language="java" import="dbUtils.DbConn" %>

    <%
        String logonLink = "";
        String msg = ""; //overrall message

        StringData loggedOnUser = (StringData) session.getAttribute("user"); //gets object/attribute set from logon.jsp

        if (loggedOnUser == null) { //meaning user is not logged in
            try {
                msg = "";
                logonLink = "<span id=\"logg\"><a href ='logonMobile.jsp'>LOG ON</a></span>"; //show a Log On link if no user is logged in
            } catch (Exception e) {
                msg += " Exception was thrown: " + e.getMessage();
            }

        } else { //meaning user is logged in
            try {
                msg = "Welcome " + loggedOnUser.user_name + "!";
                logonLink = "<span id=\"logg\"><a href = 'logoff.jsp'>Log Off</a></span>"; //show log of link if user is logged in, brings them to logoff.jsp
            } catch (Exception e) {
                msg += " Exception was thrown: " + e.getMessage();
            }
        }
    %>

    <style>
        .pageTitle{
            position: relative;
            padding-top:22px;
            margin-right:60px;
            text-align: left;
        }
        
        #nav{
            z-index:2;       /* added for fixed layout: keeps titleNav on top of other elemements */
            position:absolute; /* added for fixed layout */
            top:0px;        /* added for fixed layout */
            left:0px;       /* added for fixed layout */
            width:100%;     /* added for fixed layout */
            color:white;
            font-family: serif;
            background-color: #f2f2f2;
            height: 35px;
            background-color:white;
            min-width: 350px;
        }

        body{
            
            font-family: 'Noto Sans', sans-serif;
            margin:0;
            width:100%;
            height:100vh;
            /*background:url('https://wallpaperscraft.com/image/sun_leaves_mint_plant_74320_360x640.jpg');*/
            background:#f4f4f4;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            background-attachment: fixed;          
        }

        header{
            width:100%; 
            background:#ffffff; 
            height:60px; 
            line-height:60px;
            border-bottom:1px solid #dddddd;
        }

        .hamburger{
            background:none;
            position:absolute;
            top:0;
            right:0;
            line-height:45px;
            padding:5px 15px 0px 15px;
            color:#999;
            border:0;
            font-size:1.4em;
            font-weight:bold;
            cursor:pointer;
            outline:none;
            z-index:10000000000000;
        }

        .cross{
            background:none;
            position:absolute;
            top:0px;
            right:0;
            padding:7px 15px 0px 15px;
            color:#999;
            border:0;
            font-size:3em;
            line-height:65px;
            font-weight:bold;
            cursor:pointer;
            outline:none;
            z-index:10000000000000;
        }

        .menu{
            z-index:1000000; 
            font-weight:bold; 
            font-size:0.8em; 
            width:100%; 
            background:#f1f1f1;  
            position:absolute; 
            text-align:center; 
            font-size:12px;

        }
        .menu ul {margin: 0; padding: 0; list-style-type: none; list-style-image: none;}
        .menu li {display: block;   padding:15px 0 15px 0; border-bottom:#dddddd 1px solid;}
        .menu li:hover{display: block;    background:#ffffff; padding:15px 0 15px 0; border-bottom:#dddddd 1px solid;}
        .menu ul li a { text-decoration:none;  margin: 0px; color:#666;}
        .menu ul li a:hover {  color: #666; text-decoration:none;}
        .menu a{text-decoration:none; color:#666;}
        .menu a:hover{text-decoration:none; color:#666;}

        .glyphicon-home{
            color:white; 
            font-size:1.5em; 
            margin-top:5px; 
            margin:0 auto;
        }
        header{display:inline-block; font-size:12px;}
        span{padding-left:20px;}
        a{color:#336699;}Ï
    </style> 


    <header>
        <button class="hamburger">&#9776;</button>
        <button class="cross">&#735;</button>
    </header>

    <div id="title">
        <div id="nav">
            <div class="pageTitle">
                <%out.print(msg);%>

                &nbsp;

                <%out.print(logonLink);%>

            </div>




            <div class="menu">
                <ul>
                    <a href="indexMobile.jsp"><li>HOME</li></a>   
                    <a href="systemMobile.jsp?system_id=<%if(loggedOnUser != null){ out.print(loggedOnUser.system_ip);}%>"><li>SYSTEM DIAGNOSTICS</li></a> 
                    <a href="aboutMobile.jsp"><li>ABOUT</li></a>
                    <a href="contactMobile.jsp"><li>CONTACT US</li></a> 
                </ul>
            </div>

            <span class="stopFloat"></span>
        </div>
    </div>

    



