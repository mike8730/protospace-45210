class CommentsController < ApplicationController

def create
  @prototype = Prototype.find(params[:prototype_id])
  @comment = Comment.new(comments_parameter)
  @comments = @prototype.comments.includes(:user)

  if @comment.save
    redirect_to prototype_path(@prototype)
  else
    render 'prototypes/show', status: :unprocessable_entity
  end
end

private
def comments_parameter
  params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: @prototype.id)
end

end
