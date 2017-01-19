class Hack < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_attached_file :image, styles: { medium: "500x500>", thumb: "250x250>" }, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


  def self.search(search)
    if search
      Hack.where("LOWER(name) LIKE ?", "%#{search}%".downcase)
    else
      Hack.all
    end
  end

end
