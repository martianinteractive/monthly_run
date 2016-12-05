class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_audit_fields

  private 

  def set_audit_fields
  Concern::Audit::Author.current = current_admin_user.id
  end
end
