class QuestionsController < ApplicationController
  before_action :authenticate,:history

# GET /questions
  def index

    if params[:title].blank? 
      @questions = Question.where(:private => false)
    else      
      @questions = Question.where( "title LIKE ?", "%#{params[:title]}%" ).where(:private => false)
    end

    if !@questions.blank?
      render json: @questions 
    else
      render :json => {:error => "not-found"}.to_json, :status => 404
    end

  end

  # GET /questions/1
  def show

    @question = Question.find(params[:id])
    if @question.private?
    	render :json => {:error => "not-found"}.to_json, :status => 404
    else
    	render :json => @question
  	end		
  end

protected
	def authenticate
	    authenticate_token || unauthorized
	end


	def authenticate_token
    	authenticate_with_http_token do |token, options|
    		Tenant.find_by(api_key: token)
      end
  end

	def unauthorized
    	self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    	render json: 'Bad credentials', status: 401
	end

	def history
		authenticate_or_request_with_http_token do |token, options|
			History.create(token: token)
		end
	end



end
