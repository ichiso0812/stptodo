class RefreshController < ApplicationController
    before_action :authorize_refresh_by_acess_request!

    def create 
        session = JWTSessions::Session.new(payload: claimless_payload, authorize_refresh_by_acess_allowed: true)
        tokens = session.authorize_refresh_by_acess_allowed do
            raise JWTSessions::Errors::Unauthorized, "Somethings not right here"
        end

        response.set_cookie(JWTSessions.access_cookie,
                            value: tokens[:access],
                            httponly: true,
                            secure: Rails.env.production?)
        render json: {csrf: tokens[:csrf]}
    end
end