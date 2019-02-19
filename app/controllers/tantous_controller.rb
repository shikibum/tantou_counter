class TantousController < ApplicationController
  def index
    @tantous = current_user.tantous
  end
end
