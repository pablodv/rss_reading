$("form.form-horizontal").remove()
$("td.<%= params[:article_id] %> .comments").append("<%= escape_javascript(render @comment) %>")
