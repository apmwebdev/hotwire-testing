# frozen_string_literal: true

# The Seeder class is for seeding the data from scratch. This is for seeding
# data gradually.
class UpdateSeeder
  def seed_post_statuses
    Post.all.each do |post|
      status_choice = rand(0..2)
      case status_choice
      when 1
        post.publish
      when 2
        post.archive
      end
    end
  end
end
