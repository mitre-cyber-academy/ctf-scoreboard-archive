class ChallengesController < ApplicationController
  
  before_filter :enforce_access
  before_filter :find_challenge, except: :index
  
  def index
    @categories = @game.categories.order(:name)
    @challenges = @game.challenges
    @title = "Challenges"
    @subtitle = %[#{pluralize(@challenges.count, "challenge")} in #{pluralize(@categories.count, "category")}]
  end
  
  def show
    @solved = @challenge.is_solved_by_user?(current_user)
    @solved_by = SolvedChallenge.where("challenge_id = :challenge", challenge: @challenge).order(:created_at).reverse_order
    flash.now[:success] = "Flag accepted!" if @solved
    @title = @challenge.name
    @subtitle = pluralize(@challenge.point_value, "point")
    @submitted_flags = to_timeline SubmittedFlag.where("challenge_id=?",params[:id]).group_by {|sf| sf.updated_at.change(:sec=>0)}
  end
  
  def submit_flag
    
    # get variables
    flag = params[:challenge][:submitted_flag]
    is_player = current_user.is_a?(Player)
    
    # audit log
    if is_player
      SubmittedFlag.create(player: current_user, challenge: @challenge, text: flag)
    end
    
    # handle flag
    if @challenge.flag == flag
      if is_player
        SolvedChallenge.create(player: current_user, challenge: @challenge)
      end
      redirect_to @challenge, flash: { success: "Flag accepted!" }
    else
      redirect_to @challenge, flash: { error: Rails.configuration.wrong_flag_messages.sample }
    end
    
  end
  
  private
    
    def find_challenge
      @challenge = @game.challenges.find(params[:id])
      if !current_user.admin? && !@challenge.open?
        raise ActiveRecord::RecordNotFound
      end
    end
  
end
