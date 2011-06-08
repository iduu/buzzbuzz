function checkSidebar() {
  var top = 0;
  $('#side_bar').css({position:'relative'});
  $(window).scroll(function() {
    newTop = $(window).scrollTop() - 30;
    newTop = newTop > 0? newTop:0;
    if (Math.abs(top - newTop) > 30) {
      top = newTop;
      $('#side_bar').clearQueue();
      $('#side_bar').animate({top:newTop});
    }
  });
}

$(checkSidebar)
