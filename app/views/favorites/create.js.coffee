$("#<%= @article.id %>").html("<%= escape_javascript link_to_favorite(current_user, @article) %>")
