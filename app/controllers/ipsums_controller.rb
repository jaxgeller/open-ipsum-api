class IpsumsController < ApplicationController
  before_action :set_ipsum, only: [:show, :update, :destroy]
  before_action :authenticate, only: [:create, :update, :destroy]


  def index
    @ipsums = Ipsum.all

    render json: @ipsums
  end

  def show
    render json: @ipsum
  end

  def create
    @ipsum = Ipsum.new(ipsum_params)
    @ipsum.user = User.find_by_token request.headers['Authorization'].split('Bearer ')

    if @ipsum.save
      render json: @ipsum, status: :created, location: @ipsum
    else
      render json: @ipsum.errors, status: :unprocessable_entity
    end
  end

  def update
    @ipsum = Ipsum.find(params[:id])

    if @ipsum.update(ipsum_params)
      head :no_content
    else
      render json: @ipsum.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @ipsum.destroy

    head :no_content
  end

  private

    def set_ipsum
      @ipsum = Ipsum.friendly.find(params[:id])
    end

    def ipsum_params
      params.require(:ipsum).permit(:title, :text)
    end
end
