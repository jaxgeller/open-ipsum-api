class IpsumsController < ApplicationController
  before_action :set_ipsum, only: [:generate, :show, :update, :destroy]
  before_action :authenticate, only: [:create, :update, :destroy]

  def index
    ipsums = paginate Ipsum.all
    render json: ipsums
  end

  def show
    count = params[:count].to_i
    if count > 10000
      render json: {error: "cannot generated that many sentences. max 10000"}
    else
      render json: @ipsum, meta: {text: @ipsum.generate(count)}, meta_key: "generated"
    end
  end

  def create
    ipsum = Ipsum.new(ipsum_params)
    ipsum.user = @current_user

    if ipsum.save
      render json: ipsum, status: :created, location: ipsum
    else
      render json: ipsum.errors, status: :unprocessable_entity
    end
  end

  def update
    if @ipsum.update(ipsum_params)
      head :no_content
    else
      render json: ipsum.errors, status: :unprocessable_entity
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
