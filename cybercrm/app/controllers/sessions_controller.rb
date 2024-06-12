class SessionsController < ApplicationController
    def create
        auth = request.env['omniauth.auth']
        user = User.from_omniauth(auth)

        array = ["willtaaa@tamu.edu", "noamgariani@tamu.edu", "pcr@tamu.edu", "john.romero@tamu.edu", "pcannell512@tamu.edu", "matthewatanas@tamu.edu", "chrisvmuniz@tamu.edu"]
        user_email = user.email

        if array.any? { |item| user_email.include?(item) }
            session[:user_id] = user.id
            redirect_to root_path, notice: 'Signed in!'
        else
            redirect_to root_path, notice: 'Failure!'
        end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: 'Signed out!'
    end
end