# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostFinder, type: :service do
  describe '#call' do
    def method_call(parent_post, child_post)
      params = { parent_slug: parent_post&.slug, child_slug: child_post&.slug }

      described_class.new(params).call
    end

    let(:parent) { create(:post) }
    let(:child) { create(:post, parent: parent) }

    context 'when /parent-post' do
      it 'returns parent post' do
        expect(method_call(parent, nil)).to eq(parent)
      end

      context 'when parent is not published yet' do
        it 'raises ActiveRecord::RecordNotFound error' do
          parent_unpublised = create(:post, published: false)

          expect do
            method_call(parent_unpublised, nil)
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'when /parent-post/child-post' do
      it 'returns child post' do
        expect(method_call(parent, child)).to eq(child)
      end

      context 'when parent is not published yet' do
        context 'when child is published' do
          it 'raises ActiveRecord::RecordNotFound error' do
            parent_unpublised = create(:post, published: false)

            expect do
              method_call(parent_unpublised, child)
            end.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
      end

      context 'when child is not published yet' do
        it 'raises ActiveRecord::RecordNotFound error' do
          child_unpublised = create(:post, parent: parent, published: false)

          expect do
            method_call(parent, child_unpublised)
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context 'when /child-post' do
      it 'raises ActiveRecord::RecordNotFound error' do
        expect do
          method_call(child, nil)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
