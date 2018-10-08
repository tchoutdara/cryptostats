class Api::CoinsController < ApplicationController
  before_action :set_coin, only: [:show, :update, :destroy]
  BASE_URL = 'https://api.coinmarketcap.com/v2/'

  def index
    render json: current_user.coins
  end

  def create
    cmc_id = params[:coin].upcase
    listings = HTTParty.get("#{BASE_URL}listings")
    listing = listings['data'].find { |l| l['symbol'] == cmc_id }
  end

  def show
    render json: @coin
  end

  def update
    current_user.watched_coins.find_by(coin_id: @coin.id).destroy
  end

  def destroy
    @coin.destroy
  end

  private
    def set_coin
      @coin = Coin.find(params[:id])
    end
end
