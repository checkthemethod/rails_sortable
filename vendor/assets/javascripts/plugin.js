(function($) {

  $.fn.railsSortable = function(options) {
    var defaults = {
      axis: 'y',
      scroll: 'true'
    };

    var setting = $.extend(defaults, options);
    setting["update"] = function() {
      var payload = $(this).sortable('serialize');
      console.log("SORTABLE:");
      console.log(payload);
      var eventId = $(this).data('event-id')
      payload = payload + "&event_id=" + eventId 
      $.post("/sortable/reorder", payload)
    }

    this.sortable(setting);
  };

})(jQuery);