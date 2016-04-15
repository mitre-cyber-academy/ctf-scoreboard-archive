class GamesController < ApplicationController
  helper :all

  def index
    redirect_to game_path
  end
  
  def show
    respond_to do |format|
      format.html {
        enable_auto_reload if @game.open?
        @divisions = @game.divisions
        @active_division = @divisions.first
        @events = @game.feed_items.order(:created_at).reverse_order.page(params[:page]).per(25)
        @title = @game.name
        @html_title = @title
        @subtitle = %[#{pluralize(@game.players.count, "team")} and #{pluralize(@game.challenges.count, "challenge")}]
        @submitted_flags = to_timeline(SubmittedFlag.all.group_by {|sf| sf.updated_at.change(:sec=>0)})
      }
      format.json
    end
  end
  
  def tos
    @title = "Terms of Service"
  end

  def summary
    @title = "Game Summary"
    @navbar_override = "summary"
    @submitted_flags = to_timeline SubmittedFlag.all.group_by {|sf| sf.updated_at.change(:min=>0)}
    hours = ((@game.stop - @game.start)/1.hours).round
    @solved_challenges = SolvedChallenge.all
    @solved_challenges.each do |sc|
      sc[:point_value] = sc.challenge.point_value 
      sc[:user_id] = sc[:id] = sc[:challenge_id] = nil     
    end
    @time_slices = ((@game.stop - @game.start)/1.hours).round
    @divisions = @game.divisions
    @active_division = @divisions.first
    @signed_in_players = Player.where("current_sign_in_ip is not null")
    @players = Player.all

  end
  
end
