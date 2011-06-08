var currentPage = 0;
var currentType = 'best';
var typeMap = {
  'best' : 0,
  'recent' : 1,
  'worst' : 2
}

function checkType () {
  currentType = $('#page_type').text();
  
  var selected = $('#tab_list li:eq(' + [typeMap[currentType]] + ')')
  selected.addClass('selected');
  
  $('.tab_unselected_tl', selected).removeClass('tab_unselected_tl').addClass('tab_selected_tl')
  $('.tab_unselected_tr', selected).removeClass('tab_unselected_tr').addClass('tab_selected_tr')
}

function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    $.post('/' + currentType + '.js?page=' + currentPage, function(data) {
      eval(data)
    });
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

$(checkScroll)
$(checkType)
