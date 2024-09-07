class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id

  def name
    "#{first_name} #{last_name}"
  end
end
