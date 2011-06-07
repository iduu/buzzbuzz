function checkSidebar() {
  Event.observe(window, 'scroll', function(evt){
    newTop = document.viewport.getScrollOffsets().top - 100;
    newTop = newTop < 0? 0:newTop;
    new Effect.Move('side_bar', {x : 0, y : newTop, mode: 'absolute'});
  });
}

document.observe('dom:loaded', checkSidebar);