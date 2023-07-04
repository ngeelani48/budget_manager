class HomeController < ApplicationController
    def index
    redirect_to transactions_path if user_signed_in?
    end
end
