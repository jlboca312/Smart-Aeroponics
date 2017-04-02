

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />

<style>

    .jumbo{
        height:200px;
    }

    .container{
        position: relative;
        padding-bottom: 25px;
        padding-left: 10px;
    }

    .container h1{
        font-size: 50px;
    }

    .container p{
        font-size: 12px;
    }

    
    
    #missionMobile{
        width: 300px;    
        padding:20px;
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
        /*background:url('https://wallpaperscraft.com/image/sun_leaves_mint_plant_74320_360x640.jpg');*/
        margin: 0 auto;

    }

    #messageMobile{

        width: 300px;
        padding:20px;
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        /*background:url('https://wallpaperscraft.com/image/sun_leaves_mint_plant_74320_360x640.jpg');*/
        background-color: #efefef;
        border-bottom:1px solid #dbdbdb;
        margin: 0 auto;

    }
</style>



<jsp:include page="jspIncludes/headToContentMobile.jsp" />




<div class="jumbo">
    <div class="container">
        <h1>SMART<br/>AEROPONICS</h1>
        <p>The modern way to grow your<br/> plants remotely and without the mess of soil.<p>


    </div>
</div>

<br> <br>


<div class="statements">

    <div id="messageMobile">
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

    <br><br><br>

    <div>
        <div id="missionMobile">
            <h1>Our Mission</h1>
            <p>Our Smart Aeroponics system will allow you to become your own farmer without the restrictive growing environments.
                It encourages you to grow, monitor, and maintain your plants from your smart phone or any device that connects to the internet.
                <a href="about.jsp"> Learn More.</a></p>
        </div>

    </div>

    <br><br>
</div>  



<jsp:include page="jspIncludes/postContent.jsp"/>
