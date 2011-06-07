var currentPage = 0;
var currentType = 'best';
var typeMap = {
  'best' : 0,
  'recent' : 1,
  'worst' : 2
}

function checkType () {
  currentType = $('page_type').textContent;
  
  var selected = $$('#tab_list li')[typeMap[currentType]]
  selected.addClassName('selected');
  selected.getElementsByClassName('tab_unselected_tl')[0].removeClassName('tab_unselected_tl').addClassName('tab_selected_tl');
  selected.getElementsByClassName('tab_unselected_tr')[0].removeClassName('tab_unselected_tr').addClassName('tab_selected_tr');
}

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    new Ajax.Request('/' + currentType + '.js?page=' + currentPage, {asynchronous:true, evalScripts:true, method:'get'});
  } else {
    setTimeout("checkScroll()", 250);
  }
}

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

document.observe('dom:loaded', checkScroll);
document.observe('dom:loaded', checkType);