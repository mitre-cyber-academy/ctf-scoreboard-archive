class KeysController < ApplicationController
  before_action :load_player

  def edit
    @key = @player.keys.find(params[:id])
  end

  def new
    @key = Key.new
  end

  def create
    @key = Key.new(params[:key])
    @key.player = @player
    if @key.save
      redirect_to @player, flash: { success: 'Key saved. Please wait a few minutes for ths to take effect.' }
    else
      flash.now[:error] = 'The key could not be saved.'
      @errors = @key.errors
      render 'new'
    end
  end

  def update
    @key = @player.keys.find(params[:id])
    if @key.update_attributes(params[:key])
      redirect_to @player, flash: { success: 'Key saved. Please wait a few minutes for ths to take effect.' }
    else
      flash.now[:error] = 'The key could not be saved.'
      @errors = @key.errors
      render 'edit'
    end
  end

  def destroy
    @key = @player.keys.find(params[:id])
    @key.destroy
    redirect_to @player, flash: { success: 'The key has been removed. Please wait a few minutes for ths to take effect.' }
  end

  private

  def load_player
    @player = Game.instance.players.find(params[:player_id])
  end
end
