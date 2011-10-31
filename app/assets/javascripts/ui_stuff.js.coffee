$ ->
  $('.alert-box a.close').bind 'click', (event) ->
    event.preventDefault()
    $(this).parent("div.alert-box").hide()
