class Api::V1::UsersController < Api::V1::BaseController
  def index
    @users = []
    User.all.each do |user|
      @users << user
    end
  end
end
