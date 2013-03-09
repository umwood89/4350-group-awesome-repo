$(document).ready(function() {
	// Initiate the carousel
	$('.carousel').carousel({
		interval : 4000
	});
	// Populate the registration form in our modal
	$.get('/register/', function(data) {
		$('#registrationform').html(data);
	});
	// Populate the registration form in our modal
	$.get('/new_listing/', function(data) {
		$('#addListingModalBody').html(data);
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

// SCRIPT FOR DOING A NON-AJAX TRADITIONAL FORM POST 
function submit(action, method, values) {
    var form = $('<form/>', {
        action: action,
        method: method
    });
    $.each(values, function() {
        form.append($('<input/>', {
            type: 'hidden',
            name: this.name,
            value: this.value
        }));    
    });
    form.appendTo('body').submit();
}

// LOGIN AJAX JSON SCRIPT
$(function() {
	$("#loginform").submit(function(e) {
		e.preventDefault();

		dataString = $("#loginform").serialize();

		$.ajax({
			type : "POST",
			url : "/JSONcheckpassword/",
			contentType : "application/json",
			data : dataString,
			dataType : "json",
			success : function(data) {
				if(data.result == 'success') {
					var username = document.getElementById('user_username').value;
					var password = document.getElementById('user_password').value;

					submit('/login/', 'POST', [
				    { name: 'username', value: username },
				    { name: 'password', value: password },
					]);
			
				} 
				else if (data.result == 'fail') {
					$('#loginresult').html("Invalid username or password");	
				}
				else {
					$('#loginresult').html(data.result);	
				}
				
			},
			failure : function(errMsg) {
				$('#loginresult').html("Request failed.");
			},
		});

	});
});


