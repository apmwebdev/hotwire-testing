class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id

  scope :archived, -> { where.not(archived_at: nil) }
  scope :drafts, -> { where(archived_at: nil, published_at: nil) }
  scope :published, -> { where(archived_at: nil).where.not(published_at: nil) }

  def archive
    update(archived_at: Time.now, published_at: nil)
  end

  def archived?
    !!archived_at
  end

  def draft?
    archived_at.nil? && published_at.nil?
  end

  def make_draft
    update(published_at: nil, archived_at: nil)
  end

  def publish
    update(published_at: Time.now, archived_at: nil)
  end

  def published?
    published_at && archived_at.nil?
  end

  def status
    return "Archived" if archived?
    return "Draft" if draft?
    return "Published" if published?
    "Unknown"
  end
end
