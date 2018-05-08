class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :password , :format => {:with => /\A(?=.*[a-zA-Z])(?=.*[0-9]).{8,}\z/, message: "must be at least 8 characters and include one number and one letter."}
  validates :username, :firstname, :lastname, :phone, :presence => true
  validates_format_of :phone, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"
  validates :phone, :numericality => true, :length => { :minimum => 10, :maximum => 11 }
end