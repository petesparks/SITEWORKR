class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @match = Match.find(params[:match_id])
  end

  def create
    @match = Match.find(params[:match_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.match = @match
    if @review.save
      redirect_to match_path(@match)
    else
      render :new
    end
  end


  private

  def review_params
    params.require(:review).permit(:content, :rating, :user)
  end
end
