# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :ensure_application_is_installed_by_facebook_user
  before_filter :ensure_authenticated_to_facebook
  
  before_filter :get_facebook_user
  
  def get_facebook_user
    @user=User.find_or_create_by_facebook_id(facebook_session.user.uid)
  end

end
