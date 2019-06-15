// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
  var isMenuDown = false;
  var isFullListDown = false;

  $('.menu-navicon>a').click(function(){
    if (isMenuDown) {
      $('.menu-dropdown').css('display', 'none');
    } else {
      $('.menu-dropdown').css('display', 'block');
      $('.menu-dropdown-sublist').css('display', 'none');
    }
    isMenuDown = !isMenuDown;
    isFullListDown = false;
  });

  $('#menu-list-toggle').click(function(){
    if (isFullListDown) {
      $('.menu-dropdown-sublist').css('display', 'none');
    } else {
      $('.menu-dropdown-sublist').css('display', 'block');
    }
    isFullListDown = !isFullListDown;
  })
});
