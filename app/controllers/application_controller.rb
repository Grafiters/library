include ApplicationHelper

class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!, only: :destroy, if: :devise_controller?
    protect_from_forgery with: :exception, if: :devise_controller?

    def paginate_response(data, page, limit)
        {
            page: page,
            limit: limit,
            total: data.total_count,
            item: data
        }
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end