// load the following using JQuery's document ready function
$(function(){

    // Listing model
    var Listing = Backbone.Model.extend({});

    // set up the view for a Listing
    var ListingView = Backbone.View.extend({
        render: function () {
            // template with ICanHaz.js (ich)
            this.el = ich.ListingRowTpl(this.model.toJSON());
            return this;
        }
    });

    // define the collection of Listings
    var ListingCollection = Backbone.Collection.extend({
        model: Listing,
        url: '/api/listings/'
    });

    // main app
    var AppView = Backbone.View.extend({
        tagName: 'tbody',
        initialize: function() {
            // instantiate a Listing collection
            this.Listings = new ListingCollection();
            this.Listings.bind('all', this.render, this);
            this.Listings.fetch();
        },

        render: function () {
        	 this.$el.html("");
            // template with ICanHaz.js (ich)
            this.Listings.each(function (Listing) {
                $(this.el).append(new ListingView({model: Listing}).render().el);
                 
            }, this);
            
            return this;
        }
    });

    var app = new AppView();
    $('#listings').append(app.render().el);
});