# module Overrides
module Api
  module V1
    module Overrides
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        include Api::V1::RegistrationsControllerDoc

        include SkipSession

        before_action :skip_session


        # Bugfix: get code from https://github.com/lynndylanhurley/devise_token_auth
        def create
          build_resource

          unless @resource.present?
            raise DeviseTokenAuth::Errors::NoResourceDefinedError,
                  "#{self.class.name} #build_resource does not define @resource,"\
                  ' execution stopped.'
          end

          # give redirect value from params priority
          @redirect_url = params.fetch(
            :confirm_success_url,
            DeviseTokenAuth.default_confirm_success_url
          )

          # success redirect url is required
          return render_create_error_missing_confirm_success_url if confirmable_enabled? && !@redirect_url

          # if whitelist is set, validate redirect_url against whitelist
          return render_create_error_redirect_url_not_allowed if blacklisted_redirect_url?(@redirect_url)

          # override email confirmation, must be sent manually from ctrl
          callback_name = defined?(ActiveRecord) && resource_class < ActiveRecord::Base ? :commit : :create
          resource_class.set_callback(callback_name, :after, :send_on_create_confirmation_instructions)
          resource_class.skip_callback(callback_name, :after, :send_on_create_confirmation_instructions)

          if @resource.respond_to? :skip_confirmation_notification!
            # Fix duplicate e-mails by disabling Devise confirmation e-mail
            @resource.skip_confirmation_notification!
          end

          if @resource.save
            yield @resource if block_given?

            unless @resource.confirmed?
              # user will require email authentication
              @resource.send_confirmation_instructions({
                                                         client_config: params[:config_name],
                                                         redirect_url: @redirect_url
                                                       })
            end

            if active_for_authentication?
              # email auth has been bypassed, authenticate user
              @token = @resource.create_token
              @resource.save!
              update_auth_header
            end

            render_create_success
          else
            clean_up_passwords @resource
            render_create_error
          end
        end

        def update
          if @resource
            if @resource.send(resource_update_method, account_update_params)
              yield @resource if block_given?
              render_update_success
            else
              render_update_error
            end
          else
            render_update_error_user_not_found
          end
        end

        def destroy
          if @resource
            @resource.destroy
            yield @resource if block_given?
            render_destroy_success
          else
            render_destroy_error
          end
        end
      end
    end
  end
end
