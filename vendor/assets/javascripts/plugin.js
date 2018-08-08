(function($) {

  $.fn.railsSortable = function(options) {
    var defaults = {
      axis: 'y',
      scroll: 'true'
    };

    var setting = $.extend(defaults, options);
    setting["update"] = function() {
      var payload = $(this).sortable('serialize');
      var eventId = $(this).data('event-id')
      payload = payload + (eventId == undefined ? '' : "&event_id=" + eventId )
      $.post("/sortable/reorder", payload)
    }

    this.sortable(setting);
  };

})(jQuery);