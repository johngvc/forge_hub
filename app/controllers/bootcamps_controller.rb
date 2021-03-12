class BootcampsController < ApplicationController
before_action :verify_authorized

  def new
    @bootcamp = Bootcamp.new
  end

  def create
    @bootcamp = Bootcamp.new(bootcamp_params)
    if @bootcamp.save
      redirect_to edit_user_registration_path(current_user), notice: "Bootcamp added to FH!"
    else
      render :new, notice: "Something went wrong, please try again."
    end
  end

private

  def verify_authorized
    true
  end

  def bootcamp_params
    params.require(:bootcamp).permit(:name, :country, :city, :website)
  end
end
