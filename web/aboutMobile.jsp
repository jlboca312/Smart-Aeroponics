<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp"/>

<style>


    .aboutContainer{
        position: relative;
        padding-top: 30px;
        margin-left: 28px;

    }

    .aboutContainer h1{
        font-size: 50px;
        padding-top: 10px;
    }


    .aboutContainer p {
        color: #808080;
        font-size: 12px;
        text-align: left;
        -webkit-text-stroke-color: black;
        font-family: 'Lato', sans-serif;
    }



    .text1{
        padding: 20px;
        margin-right:200px;
        width: 300px;    
        border-radius: 25px;
        text-align: center;
        font-size:16px;
        opacity: 0.84;
        background-color: #efefef;
        margin: 0 auto;
        
    }

    .text1 h1{
        font-size: 40px;

    }

    .text1 p{
        font-size: 16px;
    }

    .imageContainer{
        margin-right:200px;
        width: 300px;    
        border-radius: 25px;
        background-color: #efefef;
        margin: 0 auto;
        
    }
</style>

<jsp:include page="jspIncludes/headToContentMobile.jsp" />
<!-- CONTENT GOES HERE -->



<div class="aboutContainer">
    <h1>ABOUT<br/>SMART<br/>AEROPONICS</h1>
    <p>Smart Aeroponics is an aeroponics system <br/>which can be remotely maintained <br/>through an accompanying Smart Aeroponics web account.</p>
</div>

<br><br><br><br>

<div class="text1">
    <h1>SYSTEM OVERVIEW</h1>
    <p> 
        The Smart Aeroponics system allows users to become independent farmers, detached from restrictive growing environments. 
        This empowers users to grow, monitor, and maintain plants regardless of location. 
        Users can conveniently manage a small garden, consisting of a few systems, or a large-scale nursery boasting several dozen systems. 
        The Smart Aeroponics is soilless, which removes the inconvenience of traditional gardening. Using water that is rich in the nutrients
        plants need, the plants receive water to the roots directly through a misting system, giving plants easy access to minerals to enable
        healthy growing cycles and maximized yields. After setting up the hardware components of the system, users can create an account and
        register their Smart Aeroponics on the website. Furthermore, users can download the accompanying standalone mobile application, for 
        quick, convenient access from their mobile devices. This allows farmers access to their system anywhere they have access to a web 
        browser or mobile application enabling a diverse user set encompassing both desktop users and mobile device users. Users can then 
        maintain and grow plants with on-demand feedback and warnings about harmful environmental factors that could inhibit the successful 
        growth cycle of their crop.</p>
</div>

<br><br>

<div class="imageContainer">
    <h1>put image here</h1>
</div>





<jsp:include page="jspIncludes/postContent.jsp"/>