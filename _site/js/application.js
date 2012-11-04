$(document).ready(function() {

  /*
   * External links
   */
  $('a[rel=external]').click(function() {
    window.open($(this).attr('href'));
    return false;
  });

  /*
   * Cop out banner
   */
   $(window).scroll(function() {
    if ($(this).scrollTop() > 200)
    {
      $('#header').addClass('scrolled');
    }
    else
    {
      $('#header').removeClass('scrolled');
    }
   });
})