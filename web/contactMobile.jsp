<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp"/>

<style>
    .background{
        background-image:url('https://wallpaperscraft.com/image/sun_leaves_mint_plant_74320_360x640.jpg');
        top: 0;
        left: 0;
        background-size: cover;
        height: 100%;
        width:360px;
        background-attachment: fixed;
        
    }

    .contactContainer{
        position: relative;
        padding-top: 30px;
        margin-left: 28px;

    }

    .contactContainer h1{
        font-size: 50px;
        padding-top: 10px;
    }


    .contactContainer p {
        color: #808080;
        font-size: 12px;
        text-align: left;
        -webkit-text-stroke-color: black;
        font-family: 'Lato', sans-serif;
    }
</style>

<jsp:include page="headToContentMobile.jsp"/>
<!-- CONTENT GOES HERE -->

<div class="background">

    <div class="contactContainer">
        <h1>CONTACT US</h1>
        <p>Feel free to reach out<br/> to us with any questions or concerns.</p>
    </div>

</div>
<jsp:include page="jspIncludes/postContent.jsp"/>