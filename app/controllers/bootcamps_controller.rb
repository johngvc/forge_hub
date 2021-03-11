class BootcampsController < ApplicationController

  def new
    @bootcamp = Bootcamp.new
  end

  def create
    @bootcamp = Bootcamp.new(bootcamp_params)
    @bootcamp.save
  end

private
  def bootcamp_params
    params.require(:bootcamp).permit(:name, :country, :city, :website)
  end
end
