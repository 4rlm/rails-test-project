class DogBreedFetcher
  attr_reader :breed

  def initialize(name=nil)
    @name  = name || "random"
    @breed = Breed.find_or_initialize_by(name: name)
  end

  def fetch
    return @breed if @breed.pic_url.present?

    @breed.pic_url = fetch_info["message"]
    @breed.save && @breed
  end

  def self.fetch(name=nil)
    name ||= "random"
    DogBreedFetcher.new(name).fetch
  end

  def self.fetch_all
    begin
      JSON.parse(RestClient.get("https://dog.ceo/api/breeds/list/all").body)
    rescue Object => e
      rescue_msg
    end
  end

  def self.image_url_for(name)
    begin
      JSON.parse(RestClient.get("https://dog.ceo/api/breed/#{name}/images/random").body)
    rescue Object => e
      rescue_msg
    end
  end

private
  def fetch_info
    begin
      JSON.parse(RestClient.get("https://dog.ceo/api/breeds/image/#{ @name }").body)
    rescue Object => e
      default_body
    end
  end

  def default_body
    {
      "status"  => "success",
      "message" => "https://images.dog.ceo/breeds/cattledog-australian/IMG_2432.jpg"
    }
  end

  def rescue_msg
    {
      "status" => "fail",
      "message" => "Sorry, something went wrong. Please try again."
    }
  end

end
