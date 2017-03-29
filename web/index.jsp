

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />

<script type="text/javascript">
<!--
    if (screen.width <= 699) {
        document.location = "indexMobile.jsp";
    }
//-->
</script>

<style>
    .jumbo{
        background-color:rgba(0, 0, 0, 0);
        height: 800px;
        background-repeat: no-repeat;
        background-size: cover;
        background-attachment: fixed;

    }

    .jumbo .container{
        position: relative;
        padding: 1px;
        padding-top: 55px;
    }

    .jumbo h1 {
        color: black;
        font-size: 70px;  
        font-family: 'Lato', sans-serif;
        font-weight: bold;
        text-align: left;
        /*-webkit-text-stroke-width: 2px;
        -webkit-text-stroke-color: black;*/
    }

    .jumbo p {
        padding-top: 12px;
        color: #808080;
        font-size: 18px;
        text-align: left;
        -webkit-text-stroke-color: black;
        font-family: 'Lato', sans-serif;
    }



    #mission{
        float:right;
        width: 400px;    
        margin-left: 160px;
        margin-right: 150px;
        margin-bottom: 30px;
        margin-top: 252px;
        padding:20px;
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;

    }

    #message{
        /*for moving it down out of view page*/
        position: relative;
        top:177px;
        float: left;
        width: 500px;
        margin-left: 100px;
        margin-right: 50px;
        padding:20px;
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
        border-bottom:1px solid #dbdbdb;

    }
</style>


<jsp:include page="jspIncludes/headToContent.jsp" />


<div class="jumbo">
    <div class="container">
        <h1>SMART<br/>AEROPONICS</h1>
        <p>The modern way to grow your<br/> plants remotely and without the mess of soil.<p>


    </div>
</div>



<div class="statements">
    <div class="container">

        <div id="message">
            <h1>What is Aeroponics?</h1>
            <p>Aeroponics is the process of growing plants in an air or mist environment 
                without the use of soil or an aggregate medium (known as geoponics). 
                The word "aeroponic" is derived from the Greek meanings of aero- (air) 
                and ponos (labour). Aeroponic culture differs from both conventional hydroponics,
                aquaponics, and in-vitro (plant tissue culture) growing. Unlike hydroponics,
                which uses a liquid nutrient solution as a growing medium and essential 
                minerals to sustain plant growth; or aquaponics which uses water and fish waste,
                aeroponics is conducted without a growing medium. <a href="https://en.wikipedia.org/wiki/Aeroponics">See More.</a></p>

        </div>

        <div>
            <div id="mission">
                <h1>Our Mission</h1>
                <p>Our Smart Aeroponics system will allow you to become your own farmer without the restrictive growing environments.
                    It encourages you to grow, monitor, and maintain your plants from your smart phone or any device that connects to the internet.
                    <a href="about.jsp"> Learn More.</a></p>
            </div>

        </div>
    </div>

    <br><br>
</div>

<jsp:include page="jspIncludes/postContent.jsp"/>
