class Room < ActiveRecord::Base
	extend FriendlyId

	has_many :reviews, :dependent => :destroy
	belongs_to :user 

  attr_accessible :description, :location, :title

  validates_presence_of :description, :location, :title
  validates_presence_of :slug

  friendly_id :title, :use => [:slugged, :history]

  scope :most_recent, order('created_at DESC')

  def complete_name
  	"#{title}, #{location}"
  end

  def self.search(query)
  	if query.present?
  		where(['location LIKE :query OR 
  			title LIKE :query OR 
  			description LIKE :query', :query => "%#{query}"])
  	else
  		scoped
  	end
  end


end
