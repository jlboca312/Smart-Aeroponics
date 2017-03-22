$(document).ready(function () {
    $('.jumbo h1').hide().fadeIn(1500);
    $('.jumbo p').delay(1000);
    $('.jumbo p').hide().fadeIn(1500);
    $('.aboutContainer h1').hide().fadeIn(1500);
    $('.aboutContainer p').delay(1000);
    $('.aboutContainer p').hide().fadeIn(1500);
    $('.contactContainer h1').hide().fadeIn(1500);
    $('.contactContainer p').delay(1000);
    $('.contactContainer p').hide().fadeIn(1500);
    $('.resultSetFormat').delay(550);
    $('.resultSetFormat').hide().fadeIn(1000);
    $('.logon').hide().fadeIn(200);

    /* FOR MOBILE HAMBURGER MENU*/
    $(".cross").hide();
    $(".menu").hide();
    $(".hamburger").click(function () {
        $(".menu").slideToggle("slow", function () {
            $(".hamburger").hide();
            $(".cross").show();
        });
    });

    $(".cross").click(function () {
        $(".menu").slideToggle("slow", function () {
            $(".cross").hide();
            $(".hamburger").show();
        });
    });

});