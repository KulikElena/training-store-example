// = require daterangepicker

$(document).on('turbolinks:load', function() {
  $('.minimize').click(function(event) {
    var i_path = $(this).attr('src');
    $('body').append('<div id="overlay"></div><div id="magnify"><img src="'+i_path+'"><div id="close-popup"><i></i></div></div>');
    $('#magnify').css({
	    left: ($(document).width() - $('#magnify').outerWidth())/2,
            top: ($(window).height() - $('#magnify').outerHeight())/2
	  });
    $('#overlay, #magnify').fadeIn('fast');
  });

  $('body').on('click', '#close-popup, #overlay', function(event) {
    event.preventDefault();

    $('#overlay, #magnify').fadeOut('fast', function() {
      $('#close-popup, #magnify, #overlay').remove();
    });
  });

  $('#calendar_range').on('cancel.daterangepicker', function(ev, picker) {
    var today = new Date();
    var ttoday = today.toISOString().substring(0, 10).replace(/-/g,"/");
    $(this).data('daterangepicker').setStartDate(ttoday);
    $(this).data('daterangepicker').setEndDate(ttoday);
    $('#calendar_range').val(ttoday +' - ' + ttoday);
  });

  $('#calendar_range').daterangepicker({
    locale: {
      format: 'YYYY/MM/DD',
      cancelLabel: 'Clear'
    }
  });

  const book_quantity_counter = document.getElementById('book_quantity')

  if (book_quantity_counter) {
    let updateTime = function(){ book_quantity.style.display="block" }
    setTimeout(updateTime,5000);
    clearTimeout(updateTime);
  };

  $('#xxx').mousedown(function() {
    const
      xxx = document.querySelector('#xxx'),
      yyy = document.querySelector('#yyy');

    xxx.oninput = () => yyy.value = xxx.value;
    yyy.oninput = () => xxx.value = yyy.value;
  });

  $('#plus-book').click(function() {
    let input = $(this).parent().find('.book-quantity-js');
    let quantity = Number(input.val());
    input.val(quantity + 1);
  });

  $('#minus-book').click(function() {
    let input = $(this).parent().find('.book-quantity-js');
    let quantity = Number(input.val());
    if (quantity > 1) {
      input.val(quantity - 1);
    }
  });

  $('#view_more').click(function() {
    $(this).addClass("disabled");
    $(document).ajaxStop(function(){
      $(this).removeClass("disabled")
    });
  })

  $('#read-more').click(function() {
    let short_desc = $('#short-desc');
    let btn_link = $('#read-more');
    let full_desc = $('#full-desc');
    if (full_desc.css('display') == 'none') {
      short_desc.hide()
      btn_link.text('Close');
      full_desc.show();
    } else {
      short_desc.show();
      btn_link.text('Read more');
      full_desc.hide();
    }
  });
})
