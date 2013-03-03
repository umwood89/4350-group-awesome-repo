$(document).ready(function (){
	// Initiate the carousel
	$('.carousel').carousel({
		interval: 4000
	});
});

$(function() {
  // Setup drop down menu
  $('.dropdown-toggle').dropdown();
 
  // Fix input element click problem
  $('.dropdown input, .dropdown label').click(function(e) {
    e.stopPropagation();
  });
});