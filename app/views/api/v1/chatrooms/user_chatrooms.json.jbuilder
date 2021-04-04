json.array! @user_chatrooms do |chatroom|
  json.extract! chatroom, :id, :name
end
