class TweetsController < ApplicationController
    get '/tweets' do
    
        if logged_in?
          @tweets = Tweet.all
          erb :'tweets/tweets'
        else
          redirect to '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
          erb :'/tweets/create'
        else
          redirect to '/login'
        end
    end

    get '/tweets/:id' do 
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
        else
           redirect to '/login' 
        end
    end

    post '/tweets' do
        if logged_in?
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
        else
          redirect to "/tweets/new"
        end
      end
    else
      redirect to '/login'
    end
    end


    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit_tweet'
    end


    patch '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.delete
        redirect to '/tweets'
    end


    

end
