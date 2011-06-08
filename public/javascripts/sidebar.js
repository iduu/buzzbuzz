function checkSidebar() {
  var top = 0;
  $('#side_bar').css({position:'relative'});
  $(window).scroll(function() {
    newTop = $(window).scrollTop() - 200;
    newTop = newTop > 0? newTop:0;
    if (Math.abs(top - newTop) > 10) {
      top = newTop;
      $('#side_bar').clearQueue();
      $('#side_bar').animate({top:newTop});
    }
    
    if ($(window).scrollTop() > 400) {
      $('#scroll_to_top').fadeIn();
    }
    else {
      $('#scroll_to_top').fadeOut();
    }
  });
}

$(checkSidebar)
