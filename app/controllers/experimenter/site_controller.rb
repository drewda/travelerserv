class Experimenter::SiteController < ApplicationController
  def dashboard
    @travel_fixes = TravelFix.all
  end
end