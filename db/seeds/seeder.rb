# frozen_string_literal: true

class Seeder
  def seed(reset: true)
    if reset
      Resetter.reset_db
      puts "Reset DB"
    end
    seed_users
    seed_posts
    puts "DB seeded successfully!"
  end

  def seed_users
    100.times do
      User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
      )
    end
    puts "Seeded users"
  end

  def seed_posts
    User.find_each do |user|
      rand(10).times do
        user.posts.create(
          title: Faker::Book.title,
          body: create_post_body
        )
      end
    end
    puts "Seeded posts"
  end

  private

  def create_post_body
    paragraphs = []
    6.times do
      sentences = []
      rand(5..15).times do
        sentences << Faker::Lorem.sentence(word_count: 3, random_words_to_add: 10)
      end
      paragraphs << sentences.join(" ")
    end
    paragraphs.join("\n\n")
  end
end
