# frozen_string_literal: true

# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include Pundit

    before_action :authenticate_user

    rescue_from Pundit::NotAuthorizedError, with: :render_404

    protected

    def render_404
      raise ActionController::RoutingError, "Not Found"
    end

    def authenticate_user
      authorize :administrate, :administrate?
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
