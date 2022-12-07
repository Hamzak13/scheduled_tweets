class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    # Do something later

    return if tweet.published?
    
    #rescheduled a tweet to the future
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end
end
