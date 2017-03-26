

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp" />

<style>

    body{
        background:url('https://wallpaperscraft.com/image/sun_leaves_mint_plant_74320_360x640.jpg');
        
    }
    .background{
        background-image:url('https://wallpaperscraft.com/image/sun_leaves_mint_plant_74320_360x640.jpg');
        top: 0;
        left: 0;
        background-size: cover;
        height: 100%;
        width:360px;
        background-attachment: fixed;
       
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
</style>



<jsp:include page="headToContentMobile.jsp" />


<!--<div class="background">-->

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

<!--</div>-->

<jsp:include page="jspIncludes/postContent.jsp"/>
