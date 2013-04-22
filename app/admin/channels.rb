ActiveAdmin.register Channel do
  menu false

  belongs_to :user

  filter :name

  index do
    column(:name)
    column(:etag)
    column(:created_at)

    default_actions
  end

  form do |f|
    f.inputs "Channel Information" do
      f.input :name
      f.input :url
    end

    f.buttons
  end
end
