class UsersController < ApplicationController
  
  before_filter :enforce_access, only: [ :download ]
  
  def index
    @players = @game.ordered_players
    @title = "Teams"
    @subtitle = pluralize(@players.count, "team")
  end
  
  def show
    @player = Player.find(params[:id])
    @players = [@player]

    @solved_challenges = @player.solved_challenges.order("created_at DESC")
    @submitted_flags = to_timeline SubmittedFlag.where("user_id=?",params[:id]).group_by {|sf| sf.updated_at.change(:sec=>0)}
    @achievements = @player.achievements.order("created_at DESC")
    @adjustments = @player.score_adjustments.order("created_at DESC")
    @score = @player.score
    @title = @player.display_name
    @subtitle = %[#{pluralize(@score, "point")} and #{pluralize(@achievements.count, "achievement")}]
    
      render :show
  end
  
  
  def download
    if File.exists? "/opt/keys/#{current_user.email}.zip"
      send_file "/opt/keys/#{current_user.email}.zip", type: "application/zip"
    else
      player = Player.find(params[:id])
      redirect_to player, flash: {error: "Your VPN cert hasn't been generated yet. Check back in 2 minutes." }
    end
  end

end
