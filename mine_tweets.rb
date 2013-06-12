require 'rubygems'
require 'tweetstream'
require 'mongo'
require 'time'
require 'tweetstream'
require 'json'

mongo_uri = 'mongodb://dmp623:duc623@ds031098.mongolab.com:31098/wishpandadb'
db_name = 'wishpandadb'

connection = Mongo::Connection.from_uri(mongo_uri)
db = connection.db(db_name)

item_collection = db.collection('tweets')

begin
	TweetStream.configure do |config|
	  config.consumer_key       = 'YX4uQcPXYbqhY0CTEee1cA'
	  config.consumer_secret    = 'mDF4D1ui0OSIXP1dcT22YZRvD2lgDTAgqqN7jSBrk'
	  config.oauth_token        = '216810199-xVkrhdy7WHynLO6ETbJjaJMPYAj58OyUbu3MklIg'
	  config.oauth_token_secret = '1YHq62qtqdLTvBUF686gAPhjZHmawVRiE4Hdk9JV0'
	  config.auth_method        = :oauth
	end

@client = TweetStream::Client.new
 
@client.on_error do |message|
  puts "ERROR: " + message
  puts "sleeping for 1 minute"
  sleep(60)
end
 
@client.on_delete do |status_id, user_id|
  puts "deleting " + status_id.to_s
  Tweet.delete(status_id)
end
 
@client.on_limit do |skip_count|
  puts "told to limit " + skip_count
  sleep(skip_count * 5)
end
 
@client.on_enhance_your_calm do
  puts "told to calm down. Sleeping 1 minute"
  sleep(60)
end
puts "Accessing twitter searching for Turkey"
i = 1.0
TweetStream::Client.new.track('turkey') do |status|
  # Do things when nothing's wrong
  item_collection.insert({ "text" => status.text,
                           "screen_name" => status.user.screen_name,
                          "followers_count" => status.user.followers_count,
                         "profile_pic_url" => status.user.profile_image_url,
                        "user_id" => status.user.id,
                       "tweet_id" => status.id
                  #    "created_at" => status.created_at,
                    #  "coordinates" => status.coordinates
                            });
  puts i.to_s + ": "+ status.text + " FROM:  @" + status.user.screen_name 
  i += 1
end
end