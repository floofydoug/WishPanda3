class Tweet
  include Mongoid::Document
  field :user_id, type: Integer
  field :tweet_text, type: String
  field :screen_name, type: String
end
