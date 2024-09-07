# frozen_string_literal: true

class Seeder
  def seed(reset: true)
    Resetter.reset_db if reset
    seed_users
    seed_posts
  end

  def seed_users
    100.times do
      User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
      )
    end
  end

  def seed_posts
    User.find_each do |user|
      rand(10).times do
        user.posts.create(
          title: Faker::Book.title,
          body: Faker::Lorem.paragraphs(number: 3)
        )
      end
    end
  end
end
