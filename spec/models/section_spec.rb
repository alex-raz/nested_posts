# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Section, type: :model do
  let(:section) { build(:section) }

  describe 'associations' do
    it { is_expected.to belong_to(:post).optional }
    it { is_expected.to have_many(:posts).dependent(:nullify) }
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
