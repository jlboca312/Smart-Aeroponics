<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp"/>

<style>
    body{
        /*background-image:url('http://www.v3wall.com/wallpaper/1366_768/0911/1366_768_20091103093234179534.jpg');*/
        background-image: url('http://cdn.wallpapersafari.com/4/9/n2YD5J.jpg');
        background-position: left 0px;
    }


    .aboutContainer{
        position: relative;
        padding-top: 26px;
        margin-left: 40px;
        margin-top: 36px;
        
    }
    
    .aboutContainer h1{
        font-size: 55px;
        padding-top: 10px;
    }


    .aboutContainer p {
        padding-top: 20px;
        color: #808080;
        font-size: 18px;
        text-align: left;
        -webkit-text-stroke-color: black;
        font-family: 'Lato', sans-serif;
    }

    .textContainer{
        background-color: rgba(255,255, 255,.84);
        position: absolute;
        right: 0;
        left: 0;
        top:100%;
        height:98vh;
        margin-left: 50px;
        padding-top: 85px;
        
    }

    .text1{
        width: 50%;
        float: left;
    }

    .text1 h1{
        font-size: 55px;
        
    }

    .text1 p{
        font-size: 16px;
    }

    .imageContainer{
        background-color: gray;
        float: right;
        height: 77%;
        width: 25%;
        margin-right: 125px;
        opacity:1;
    }
</style>

<jsp:include page="jspIncludes/headToContent.jsp"/>
<!-- CONTENT GOES HERE -->

<div class="aboutContainer">
    <h1>ABOUT<br/>SMART<br/>AEROPONICS</h1>
    <p>Smart Aeroponics is an aeroponics system <br/>which can be remotely maintained <br/>through an accompanying Smart Aeroponics web account.</p>
</div>

<div class="textContainer">
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

    <div class="imageContainer">
        <h1>put image here</h1>
    </div>

</div>




<jsp:include page="jspIncludes/postContent.jsp"/>