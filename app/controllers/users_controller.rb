class UsersController < ApplicationController
  before_action :enforce_access, only: [:download]

  def index
    @divisions = @game.divisions
    @active_division = current_user && !current_user.admin? ? current_user.division : @divisions.first
    @title = 'Teams'
    @subtitle = pluralize(@game.players.count, 'team')
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def show
    @player = Player.find(params[:id])
    @players = [@player]

    @solved_challenges = @player.solved_challenges.order('created_at DESC')
    @submitted_flags = to_timeline SubmittedFlag.where('user_id=?',
                                                       params[:id]).group_by { |sf| sf.updated_at.change(sec: 0) }
    @achievements = @player.achievements.order('created_at DESC')
    @adjustments = @player.score_adjustments.order('created_at DESC')
    @score = @player.score
    @title = @player.display_name
    # This line is long because we need to NOT create these types of things in the controller.
    @subtitle = %(#{pluralize(@score, 'point')} and #{pluralize(@achievements.count, 'achievement')}
                in #{@player.division.name} division)
    render :show
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def download
    if File.exist? "/opt/keys/#{current_user.key_file_name}.zip"
      send_file "/opt/keys/#{current_user.key_file_name}.zip", type: 'application/zip'
    else
      redirect_to current_user, flash: { error: "Your VPN cert hasn't been
                                           generated yet. Check back in 2 minutes." }
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
