<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="jspIncludes/toHead.jsp"/>

<style>
    body{
        background-image:url('http://cdn.wallpapersafari.com/4/9/n2YD5J.jpg');
        background-position: left 0px;
    }
    
    .contactContainer{
        position: relative;
        padding-top: 55px;
        margin-left: 50px;
        
    }
    
    .contactContainer h1{
        font-size: 62px;
        padding-top: 10px;
    }


    .contactContainer p {
        padding-top: 20px;
        color: #808080;
        font-size: 18px;
        text-align: left;
        -webkit-text-stroke-color: black;
        font-family: 'Lato', sans-serif;
    }
    
    .contactDiv{
        text-align: center;
        background-color: #efefef;
        width: 500px;
        margin: auto;
        border-radius: 25px;
        padding-top: 10px;
        padding-bottom: 10px;
        opacity: 0.84;
    }
</style>

<jsp:include page="jspIncludes/headToContent.jsp"/>
<!-- CONTENT GOES HERE -->

<div class="contactContainer">
    <h1>CONTACT US</h1>
    <p>Feel free to reach out<br/> to us with any questions or concerns.</p>
</div>

<div class="contactDiv">
    <h3>Creators</h3><br>
    <div class="contactInfo">
        <p><strong>Duncan Schertler:</strong> tue52269@temple.edu</p>
        <p><strong>Nick Bock:</strong> tuf11938@temple.edu</p>
        <p><strong>Hayden French:</strong> hayden.french@temple.edu</p>
        <p><strong>Jedrick Boca:</strong> jedrick.boca@temple.edu</p>
        <p><strong>Michael Woyden:</strong> tuf35681@temple.edu</p>
        <p><strong>Jullian Gerhart:</strong> jullian.gerhart@temple.edu</p>
        <p><strong>Charles Patterson:</strong> tuf46632@temple.edu</p>
        <p><strong>Colin Small:</strong> tuf84887@temple.edu</p>
        <p><strong>Keng Cong:</strong> tuf73429@temple.edu</p>
    </div>
</div>

<br><br>


<jsp:include page="jspIncludes/postContent.jsp"/>