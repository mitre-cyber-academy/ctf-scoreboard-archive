# frozen_string_literal: true
class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:new, :create], if: :json_request?
  respond_to :json
end
