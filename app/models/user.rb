class User < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: true

  validates :password,
    presence: true

  has_many :posts, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  def posts
    return Post.where(user_id: self.id)
  end
end
