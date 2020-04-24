class Review < ApplicationRecord
  belongs_to :user
  
  has_many :comments, :dependent => :delete_all

  validates :title, presence: true,length: {minimum: 5}
	validates :description,presence: true
end
