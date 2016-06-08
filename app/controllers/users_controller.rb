class UsersController < ApplicationController
  
  before_filter :enforce_access, only: [ :download ]
  
  def index
    @divisions = @game.divisions
    @active_division = current_user && !current_user.admin? ? current_user.division : @divisions.first
    @title = "Teams"
    @subtitle = pluralize(@game.players.count, "team")
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
    @subtitle = %[#{pluralize(@score, "point")} and #{pluralize(@achievements.count, "achievement")} in #{@player.division.name} division]
    
      render :show
  end
  
  
  def download
    if File.exists? "/opt/keys/#{current_user.key_file_name}.zip"
      send_file "/opt/keys/#{current_user.key_file_name}.zip", type: "application/zip"
    else
      player = Player.find(params[:id])
      redirect_to player, flash: {error: "Your VPN cert hasn't been generated yet. Check back in 2 minutes." }
    end
  end

  private
  def user_params 
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  
  def player_params
    params.require(:player).permit(:game_id, :tags, :display_name, :city, :affiliation)
  end
end
