class Breed < ActiveRecord::Base
  validates_presence_of :name, :pic_url
end
