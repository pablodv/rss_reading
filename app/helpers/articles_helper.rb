module ArticlesHelper
  def link_to_favorite(user, resource)

    if resource.users_articles.present?
      path = destroy_favorite_path(user, resource.id)
      opt = { method: :delete, class: "favorite", remote: true}
      star = content_tag(:i, "", class: "icon-star")
    else
      path = create_favorite_path(user, resource.id)
      opt = { method: :post, class: "favorite", remote: true}
      star = content_tag(:i, "", class: "icon-star-empty")
    end

    link_to(path, opt){ star }
  end
end
