// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap/
//= require fancybox/jquery.fancybox
//= require pwdstr/pwdstr
//= require 3dlinks
//= require scrolltopcontrol

jQuery(document).ready(function() {
  var interval, rotation, viewportHeight, viewportWidth;
  rotation = 0;
  viewportWidth = $(document).width();
  viewportHeight = $(document).height();
  jQuery.fn.rotate = function(degrees) {
    return $(this).css({
      "-webkit-transform": "rotate(" + degrees + "deg)",
      "-moz-transform": "rotate(" + degrees + "deg)",
      "-ms-transform": "rotate(" + degrees + "deg)",
      transform: "rotate(" + degrees + "deg)"
    });
  };
  interval = setInterval(function() {
    rotation += 5;
    $(".rotate").rotate(rotation);
  }, 90);
  return $(".rotate").animate({
    left: viewportWidth - 280,
    top: viewportHeight - 280
  }, 20000, "linear", function() {
    return clearInterval(interval);
  });
});

$(".notice_link").hover(function () {
  $('.notice_link').popover('show');
},
function (){
  $('.notice_link').popover('hide');
});

$(document).ready(function() {
  $(".fancybox")
     .attr('rel', 'gallery')
     .fancybox({
	beforeShow: function () {
	/* Add watermark */
	  $('<div class="watermark"></div>')
	  .bind("contextmenu", function (e) {
		return false; /* Disables right click */
	  })
	.prependTo( $.fancybox.inner );   
	}
     });
});

jQuery(document).ready(function() {
$("#user_password").pwdstr("#password_time");

  setInterval(function() {
     if($("#password_time").is(":empty")||$("#user_password").val() == ''){
	$(".password_oblicz").hide('fast');
     }
     else{
	$(".password_oblicz").show('fast');
     }
  return
}, 1500);
});

$(document).ready(function() {
  $("a.list_show").click(function() {
    var parentId = jQuery(this).attr("id");
    $("div#"+parentId).slideDown("slow");
  });
  $("a.list_hide").click(function() {
    var parentId = jQuery(this).attr("id");
    $("div#"+parentId ).slideUp();
  });
});

jQuery(document).ready(function() {
$("#slideshow > div:gt(0)").hide();

setInterval(function() { 
  $('#slideshow > div:first')
    .fadeOut(1000)
    .next()
    .fadeIn(1000)
    .end()
    .appendTo('#slideshow');
},  6000);
});
