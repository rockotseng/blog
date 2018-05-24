class ApplicationController < ActionController::Base

  protected

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end

end
