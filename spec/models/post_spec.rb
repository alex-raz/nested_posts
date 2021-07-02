# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build(:post) }

  describe 'associations' do
    it { is_expected.to belong_to(:parent).optional }

    it {
      expect(post).to(
        have_many(:children)
          .dependent(:nullify)
          .class_name('Post')
          .with_foreign_key(:parent_id)
      )
    }

    it { is_expected.to belong_to(:section).optional }
    it { is_expected.to have_many(:sections).dependent(:destroy) }
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
