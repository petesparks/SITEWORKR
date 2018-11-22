class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @match = Match.find(params[:match_id])
    @review = Review.new(review_params)
    @review.match = @match
    if @review.save
      redirect_to match_path(@match)
    else
      render 'match/show'
    end

  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
