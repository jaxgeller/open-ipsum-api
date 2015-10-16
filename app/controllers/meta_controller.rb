class MetaController < ApplicationController
  def index
    render json: {status: 'okay'}, head: 200
  end
end
