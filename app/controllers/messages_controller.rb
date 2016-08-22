# frozen_string_literal: true
class MessagesController < ApplicationController
  def index
    @messages = @game.messages.order(:updated_at).reverse_order.page(params[:page]).per(10)
    @messages_count = 0
    current_user.update_attribute(:messages_stamp, Time.now.utc)
    @title = 'Messages'
    @subtitle = pluralize(@messages.count, 'message')
  end
end
