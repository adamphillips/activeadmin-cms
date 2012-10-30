(function( $ ) {
  $.fn.quickFilter = function(targetSelector, options) {

    var $subject = this;

    applyFilter = function(filter, event) {
      var term = $subject.val();
      if (event)
      {
        term += String.fromCharCode(e.keyCode);
      }

      $(targetSelector).hide();
      $(targetSelector).each(function() {
        $this = $(this)
        text = $this.text().toLowerCase();
        if(text.indexOf(String(term).toLowerCase()) >= 0)
        {
          $this.show();
        }
      });

      $subject.trigger('quickFilter.complete');
    }

    $subject.click(applyFilter).keyup(applyFilter);
    applyFilter();

    return $subject;
  };
})(jQuery);