class API::V1::Paper::CardsController < ApplicationController
  before_action :authenticate_token
  skip_before_action :verify_authenticity_token

  def create
    @paper_card = Paper::Card.new(paper_card_params)

    if @paper_card.save
      render json: { message: "Card was successfully created.", card: @paper_card }, status: :created
    else
      render json: { errors: @paper_card.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_token
    token = request.headers['Authorization']
    if token != "Bearer #{ENV['API_BEARER_TOKEN']}"
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def paper_card_params
    params.require(:paper_card).permit(:image)
  end
end
