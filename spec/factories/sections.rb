# frozen_string_literal: true

FactoryBot.define do
  factory :section do
    name { Faker::University.suffix }
    sequence(:position) { |n| n }
  end
end

# == Schema Information
#
# Table name: sections
#
#  id         :bigint           not null, primary key
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint
#
# Indexes
#
#  index_sections_on_post_id  (post_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#
