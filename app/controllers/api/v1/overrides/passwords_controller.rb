# module Overrides
module Api
  module V1
    module Overrides
      class PasswordsController < DeviseTokenAuth::PasswordsController
        include Api::V1::PasswordsControllerDoc

        include SkipSession

        before_action :skip_session

        # Bugfix: get code from https://github.com/lynndylanhurley/devise_token_auth
        def create
          return render_create_error_missing_email unless resource_params[:email]

          @email = get_case_insensitive_field_from_resource_params(:email)
          @resource = find_resource(:uid, @email)

          if @resource
            yield @resource if block_given?
            @resource.send_reset_password_instructions(
              email: @email,
              provider: 'email',
              redirect_url: @redirect_url,
              client_config: params[:config_name]
            )

            if @resource.errors.empty?
              render_create_success
            else
              render_create_error @resource.errors
            end
          else
            render_not_found_error
          end
        end

        def update
          # make sure user is authorized
          if require_client_password_reset_token? && resource_params[:reset_password_token]
            @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])
            return render_update_error_unauthorized unless @resource

            @token = @resource.create_token
          else
            @resource = set_user_by_token
          end

          return render_update_error_unauthorized unless @resource

          # make sure account doesn't use oauth2 provider
          return render_update_error_password_not_required unless @resource.provider == 'email'

          # ensure that password params were sent
          unless password_resource_params[:password] && password_resource_params[:password_confirmation]
            return render_update_error_missing_password
          end

          if @resource.send(resource_update_method, password_resource_params)
            @resource.allow_password_change = false if recoverable_enabled?
            @resource.save!

            yield @resource if block_given?
            render_update_success
          else
            render_update_error
          end
        end
      end
    end
  end
end
