require 'apis/twitter_api_wrapper'

module BrattyPack
  module Routes
    class Twitter < Base
      TWITTER_CREDENTIALS = Secrets.keys('twitter')
      @@twitter_wrapper = TwitterAPIWrapper.new(TWITTER_CREDENTIALS)


      get '/twitter/users' do
        user_ids = process_text_input_array(params['user_names'])
        @results = @@twitter_wrapper.fetch(:users, user_ids)

        slim :'twitter/users'
      end
    end
  end
end