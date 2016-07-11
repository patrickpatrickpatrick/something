class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :mailbox

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
    
  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation

    if current_user.role != "admin"
      @conversation ||= mailbox.conversations.find(params[:id])
    else
      @conversation ||= Mailboxer::Conversation.find(params[:id])
    end

  end

  protected

  def configure_permitted_parameters
  	added_attrs = [:name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
