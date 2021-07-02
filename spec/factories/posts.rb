# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    body { Faker::Lorem.paragraph(sentence_count: 5) }
    parent { nil }
    published { true }
    sequence(:position) { |n| n }
    slug { title.parameterize }
    title { Faker::University.name }
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
