class CommentsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	include CommentsHelper

	def create

		@comment = Comment.new(comment_params)
		@comment.review_id = params[:review_id]
		@comment.user_id = current_user.id
		@comment.save

		redirect_to review_path(@comment.review)

	end

	def edit

		# byebug
		@review = Review.find(params[:review_id])
		@comment = Comment.find(params[:id])

   		respond_to do |format|
      		format.js
   		end		
	end

	def update
		
		@review = Review.find(params[:review_id])
		@comment = Comment.find(params[:id])

		@comment.update(comment_params)
		@comment.review_id = params[:review_id]
		@comment.user_id = current_user.id
		respond_to do |format|
	      format.html
	      format.js
		end
	end

	def destroy
		
		@review = Review.find(params[:review_id])
		@comment = @review.comments.find(params[:id])
		@comment.destroy

		redirect_to review_path(@review)
	end

end
