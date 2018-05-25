class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @author = Author.from_omniauth(request.env['omniauth.auth'])

    if @author.persisted?
      sign_in_and_redirect @author, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_author_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end