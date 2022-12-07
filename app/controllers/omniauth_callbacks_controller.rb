class OmniauthCallbacksController < ApplicationController

    def twitter
        #checks if database has an existing account of this username. Will return that first
        #otherwise it will create a new one
        #The method will then update the account depending on the auth
        twitter_account= Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
            
        twitter_account.update(
            name: auth.info.name, 
            username: auth.info.nickname,
            image: auth.info.image,
            token: auth.credentials.token,
            secret: auth.credentials.secret,
        )

        redirect_to twitter_accounts_path, notice: "Sucessfully connected Twitter Account!"
    end

    def auth
        request.env['omniauth.auth']
    end

end
