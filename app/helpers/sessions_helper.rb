module SessionsHelper

	def signed_in_user
		unless signed_in?
			redirect_to root_url
		end
	end

	def sign_in(user)
		session[:id] = user.id
	end

	def current_user
    @current_user ||= User.find_by(id: session[:id])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session.delete(:id)
    @current_user = nil
  end
end
