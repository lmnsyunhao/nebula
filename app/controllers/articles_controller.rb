class ArticlesController < ApplicationController
  include SessionsHelper
  include ChatsHelper
	def create
		article = Article.new(user_id: current_user.id, content: params[:post][:body])
		if article.save
			redirect_to chats_path, flash: {"success": "发送成功"}
		else
			redirect_to chats_path, flash: {"error": "发送失败"}
		end
	end

	def destroy
		article = Article.find_by_id(params[:id])
		article.destroy
		redirect_to chats_path, flash: {"success": "刪除成功"}
	end

	def show
		if params[:id].to_s == current_user.id.to_s
			redirect_to chats_path
			return
		end
    @friends=current_user.friends+current_user.inverse_friends
    @userinfo = User.find_by_id(params[:id])
    @onlineusers = @userinfo.friends+@userinfo.inverse_friends-[current_user]
    @selfarticle = @userinfo.articles
	end

end
