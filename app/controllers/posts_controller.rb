class PostsController < InheritedResources::Base
  before_action :authenticate_user!

  def new
     @post = Post.new
  end

  def create
   params[:post][:user_id] = current_user.id
   @post = Post.new(post_params)

   respond_to do |format|
      if @post.save
         format.html { redirect_to @post, notice: 'Recipe was successfully created.' }
         format.json { render :show, status: :created, location: @post }
      else
         format.html { render :new }
         format.json { render json: @post.errors, status: :unprocessable_entity }
      end
   end
 end

  private

    def post_params
      params.require(:post).permit(:user_id, :title, :body)
    end

end
