class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    provider_authentication
  end

  def twitter
    provider_authentication
  end

  private

  def provider_authentication
    provider = request.env["omniauth.auth"].provider.split("_")[0]
    @user    = User.find_or_create_with_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: provider.titleize
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end