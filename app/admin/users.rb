ActiveAdmin.register User do
  actions :all, except: [:new, :create]

  filter :first_name
  filter :last_name
  filter :email

  index do
    column :first_name
    column :last_name
    column :email
    column(""){ |u| link_to "Channels", [:admin, u, :channels] }

    default_actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
      row(:avatar){ |u| image_tag(u.avatar.url(:large)) }
    end
  end

  form html: { multipart: true } do |f|
    f.inputs "User Information" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :avatar, as: :file,
        hint: (f.template.image_tag(f.object.avatar.url(:medium)) if f.object.avatar.present?)
    end

    f.buttons
  end
end
