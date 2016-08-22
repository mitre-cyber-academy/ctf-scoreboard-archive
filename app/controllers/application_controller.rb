class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include ActionView::Helpers::TextHelper

  before_action :load_game, :load_messages_count

  def to_timeline(data, style = nil)
    output = []
    data.keys.each do |key|
      output << { date: key, style: style, count: data[key].length }
    end
    output
  end

  def enable_auto_reload
    @auto_reload = false
  end

  # rubocop:disable MethodLength
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def load_game
    @game = Game.instance
    raise ActiveRecord::RecordNotFound unless @game
    unless current_user.nil?
      now = Time.zone.now
      if now < @game.start
        flash.now[:info] = 'The game will open ' +
                           simple_format("on #{@game.start.strftime('%b %e %y, %R %Z')}.", '', wrapper_tag: 'strong')
      elsif now < @game.stop && now > @game.stop - 1.hour
        flash.now[:info] = 'The game will stop accepting submissions ' +
                           simple_format("on #{@game.stop.strftime('%b %e %y, %R %Z')}", '', wrapper_tag: 'strong')
      else
        flash.now[:info] = I18n.t('game.closed') unless @game.open?
      end
    end
  end
  # rubocop:enable MethodLength
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  def load_messages_count
    unless current_user.nil?
      time = current_user.messages_stamp
      @messages_count = if time.nil?
                          @game.messages.count
                        else
                          @game.messages.where('updated_at >= :time', time: time.utc).count
                        end
    end
  end

  def enforce_access
    deny_access unless current_user
  end

  def after_sign_in_path_for(_user)
    root_path
  end
end
