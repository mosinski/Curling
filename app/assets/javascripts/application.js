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
//= require_tree .
//= require redactor-rails/redactor.min
//= require /custom/config

jQuery(document).ready(function() {
  return jQuery(".abtlikebox").hover((function() {
    return jQuery(this).stop().animate({
      right: "0"
    }, "medium");
  }), (function() {
    return jQuery(this).stop().animate({
      right: "-250"
    }, "medium");
  }), 500);
});

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


$('a[rel=popover]').popover({
  html: true,
  trigger: 'hover',
  placement: 'right',
  content: function(){return '<img src="'+$(this).data('img') + '" />';}
});


