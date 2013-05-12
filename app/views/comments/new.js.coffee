$("td.<%= params[:article_id] %>").append("<%= escape_javascript(render 'form') %>")
