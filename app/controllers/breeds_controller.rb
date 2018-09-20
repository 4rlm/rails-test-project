class BreedsController < ApplicationController

  def index
    payload = DogBreedFetcher.fetch_all
    if payload["status"] == "success"
      @breed_names = payload["message"].keys
    else
      @error_msg = payload["message"]
    end
  end

  def show_detail
    @breed_name = params[:breed_name]

    payload = DogBreedFetcher.image_url_for(@breed_name)

    if payload["status"] == "success"
      @breed_img_url = payload["message"]
    else
      @error_msg = payload["message"]
    end
  end

  def create
    #code
  end

end
