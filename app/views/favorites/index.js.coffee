$(".span8").html("")
$(".span8").html("<%= escape_javascript(render partial: 'shared/articles', locals:{ title: 'My Favorites', articles: @favorites }) %>")