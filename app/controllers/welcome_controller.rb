class WelcomeController < ApplicationController

  def index

  	@questions = Question.all.count
  	@answers = Answer.all.count
  	@requests = History.all.group(:token).count
  	@users = User.all.count
    
  end
end
