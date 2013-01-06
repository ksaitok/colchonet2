class Room < ActiveRecord::Base
  attr_accessible :description, :location, :title

  validates_presence_of :description, :location, :title

  def complete_name
  	"#{title}, #{location}"
  end
end
