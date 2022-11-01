class MainController < ApplicationController
    def index
        flash.now[:notice] = "logged in successfully"
        flash.now[:alert] = "Invalid email or password"

    end


end