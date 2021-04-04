json.array! @chatrooms do |chatroom|
  json.extract! chatroom, :name, :users
end
