$(".span8").html("")
$(".span8").html("<%= escape_javascript(render partial: 'articles') %>")