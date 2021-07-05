# frozen_string_literal: true

class Post < ApplicationRecord
  before_destroy :check_if_post_is_destroyable

  belongs_to :parent, class_name: 'Post', optional: true
  has_many(
    :children,
    class_name: 'Post',
    dependent: :nullify,
    foreign_key: :parent_id,
    inverse_of: :parent
  )
  has_many :sections, dependent: :destroy
  belongs_to :section, optional: true

  scope :published, -> { where(published: true) }
  scope :parents, -> { where(parent_id: nil) }
  scope :sectionless, -> { where(section_id: nil) }

  def parent?
    parent_id.nil?
  end

  private

  def check_if_post_is_destroyable
    destroyable = children.blank? && sections.blank?
    return true if destroyable

    errors.add(:base, 'You may not delete this Parent Post.')

    # Returning false in Active Record and Active Model callbacks
    # will not implicitly halt a callback chain starting from Rails 5.1
    throw :abort
  end
end

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text
#  position   :integer
#  published  :boolean          default(FALSE), not null
#  slug       :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#  section_id :bigint
#
# Indexes
#
#  index_posts_on_parent_id   (parent_id)
#  index_posts_on_section_id  (section_id)
#  index_posts_on_slug        (slug)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => posts.id)
#  fk_rails_...  (section_id => sections.id)
#
