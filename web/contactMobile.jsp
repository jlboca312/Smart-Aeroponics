<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp"/>

<style>
    body{
        background-image:url('http://cdn.wallpapersafari.com/4/9/n2YD5J.jpg');
        background-position: left 0px;
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

<div class="contactContainer">
    <h1>CONTACT US</h1>
    <p>Feel free to reach out<br/> to us with any questions or concerns.</p>
</div>


<jsp:include page="jspIncludes/postContent.jsp"/>