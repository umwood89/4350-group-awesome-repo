
$(function(){
    var Offer = Backbone.Model.extend({});
    // set up the view for a Offer
    var OfferView = Backbone.View.extend({
        render: function () {
            // template with ICanHaz.js (ich)
            this.el = ich.OfferRowTpl(this.model.toJSON());
            return this;
        }
    });
    // define the collection of Offers
    var OfferCollection = Backbone.Collection.extend({
        model: Offer,
        url: '/api/offers'
    });
    // main app
    var AppView = Backbone.View.extend({
        tagName: 'tbody',
        initialize: function() {
            // instantiate a Offer collection
            this.Offers = new OfferCollection();
            this.Offers.bind('all', this.render, this);
            this.Offers.fetch();
        },
 
        render: function () {
            // template with ICanHaz.js (ich)
            this.$el.html("");
            this.Offers.each(function (Offer) {
                $(this.el).append(new OfferView({model: Offer}).render().el);
            }, this);
 
            return this;
        }
    });
 
    var app = new AppView();
    $('#offers').append(app.render().el);
});

