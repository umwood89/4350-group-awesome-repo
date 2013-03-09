// load the following using JQuery's document ready function
$(function(){

    // Listing model
    var Listing = Backbone.Model.extend({
    	remove: function()
    	{
    		this.destroy();
    	},
    	
    	//validation function
    	validate: function(attrs)
    	{
    		if(attrs.title.length == 0)
    		{
    			return "Please enter a valid title";
    		}
    		
    		//add more later
    	}
    });

    // set up the view for a Listing
    var ListingView = Backbone.View.extend({
    	tagName: 'tr',
    	events: 
    	{
    		"click a.edit" : "editListing",
    		"click a.destroy" : "removeListing"
    	},
    	
    	editListing: function(event)
    	{
    		event.preventDefault();
    		event.stopImmediatePropagation();
    		
    		//call main app, pass model in for updating
    		this.options.app.editListing(this.model);
    	},
    	removeListing: function(event)
    	{
    		event.preventDefault();
    		event.stopImmediatePropagation();
    		if(confirm("Are you sure you want to delete this entry?"))
    		{
    			this.model.remove();
    		}
    	},
        render: function () {
            // template with ICanHaz.js (ich)
            $(this.el).html(ich.ListingRowTpl(this.model.toJSON()));
            return this;
        }
    });

    // define the collection of Listings
    var ListingCollection = Backbone.Collection.extend({
        model: Listing,
        url: '/api/listings'
        
        //want to compare by date created
        //comparator: function(obj1, obj2)
        //{
        //	return obj1.get('date_created').localeCompare(obj2.get('date_created'));
        //}
    });
    
    var ListingsView = Backbone.View.extend({
    	tagname: 'tbody',
    	
    	initialize: function(options)
    	{
    		//initialize necessary variables
    		this.listingsList = new ListingCollection();
    		this.listingsList.bind('all', this.render, this);
    		this.listingsList.fetch();
    	},
    	
    	addOne: function(listing)
    	{
    		//need to pass reference to main app
    		this.$el.append(new ListingView({model: listing, app: this.options.app}).render().el);
    		return this;
    	},
    	
    	addNew: function(listing)
    	{
    		this.listingsList.create(listing);
    		return this;
    	},
    	
    	
    	
    	updateListing: function(listingData)
    	{
    		var listing = this.listingsList.get({id: listingData.listing_id});
    		if(_.isObject(listing))
    		{
    			//iterate through the data, and add it to the model
    			for(var key in listingData)
    			{
    				if(key == 'photo')
    				{
    					
    				}
    				//dont copy id, already checked
    				if(key != 'listing_id')
    				{
    					listing.set(key,listingData[key]);
    				}
    			}
    			listing.save();
    			//this.listings.sort();
    		}
    	},
    	
    	render : function()
    	{
    		this.$el.html('');
    		this.listingsList.each(this.addOne, this);
    		return this;
    	}
    	
    });
    

    // main app view
    var AppView = Backbone.View.extend({
    	el: '#app',
    	events: 
    	{
    		"click #listingForm :submit" : "handleModal",
    		"keydown #listingForm" : "handleModalOnEnter",
    		"hidden #listingModal" : "prepareForm"
    	},
        tagName: 'tbody',
        initialize: function() {
            // instantiate a Listing collection
            this.listings = new ListingsView({app: this});
        },

        render: function () {
        	 //pass the rendering to the ListingsView
        	 this.$el.find('table').append(this.listings.render().el);
 
        },
        
        //update existing listing
        editListing: function(listing)
        {
        	this.prepareForm(listing.toJSON());
        	
        	//store in the modal itself
        	$('#listingModal').data('client_id', listing.cid);
        	$('#listingModal').modal('show');
        },
        
        //gets the form ready
        prepareForm: function(listingData)
        {
        	listingData = listingData || {};
        	var data = 
        	{
        		'title': '',
        		'description': '',
        		'user': '',
        		'photo': '',
        		'trade_completed': '',
        		'date_created': '',
        		'date_completed': ''
        	};
        	
        	$.extend(data,listingData);
        	
        	var form = $('#listingForm');
        	$(form).find('#id_title').val(data.title);
        	$(form).find('#id_description').val(data.description);
        	$(form).find('#id_user').val(data.user);
        	$(form).find('#id_user').readOnly = true;
        	//$(form).find('#id_photo').val(data.photo);
        	$(form).find('#id_trade_completed').val(data.trade_completed);
        	$(form).find('#id_date_created').val(data.date_created);
        	$(form).find('#id_date_completed').val(data.date_completed);
        	
        	//clear previous references (in case cancel was clicked)
        	$('#listingModal').data('client_id', '')

        },
        
        handleModal: function(event) 
        {
        	event.preventDefault();
        	event.stopImmediatePropagation();
        	var form = $('#listingForm');
        	
        	var listingData = 
        	{
        		title: $(form).find('#id_title').val(),
        		description: $(form).find('#id_description').val(),
        		//user: $(form).find('#id_user').val(),
        		photo: $(form).find('#id_photo').val(),
        		trade_completed: $(form).find('#id_trade_completed').val(),
        		date_created: $(form).find('#id_date_created').val(),
        		date_completed: $(form).find('#id_date_completed').val(),
        	};
        	
        	if($('#listingModal').data('client_id'))
        	{
        		listingData.listing_id = $('#listingModal').data('client_id');
        		this.listings.updateListing(listingData);
        	}
        	else
        	{
        		this.listings.addNew(listingData);
        	}
        	
        	//hide the modal
        	$('#listingModal').modal('hide');
        	
        	return this;
        	
        },
        
        //this is just to process the modal if enter key is pressed
        handleModalOnEnter: function(event) 
        {
        	if(event.keyCode == 13)
        	{
        		return this.handleModal(event);
        	}
        }
    });

    var app = new AppView();
    app.render();
});