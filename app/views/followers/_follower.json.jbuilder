json.extract! follower, :id, :user, :follower_id, :created_at, :updated_at
json.url follower_url(follower, format: :json)