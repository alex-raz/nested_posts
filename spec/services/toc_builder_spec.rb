# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TocBuilder, type: :service do
  describe '#call' do
    def method_call(parent)
      described_class.new(parent).call
    end

    it 'builds Table of Contents for a given Parent Post' do
      parent = create(:post, title: 'Parent Post', position: 1, published: true)
      section2 = create(:section, post: parent, name: 'Second Section', position: 2)
      parent.update(section: section2) # add parent post to the second section
      child1 = create(
        :post, title: 'Child 1', position: 2, published: true, section: section2, parent: parent
      )
      child2 = create(
        :post, title: 'Child 2', position: 3, published: true, section: section2, parent: parent
      )
      section1 = create(:section, post: parent, name: 'First Section', position: 1)
      child3 = create(
        :post, title: 'Child 3', position: 7, published: true, section: section1, parent: parent
      )
      child4 = create(
        :post, title: 'Child 4', position: 7, published: true, section: section1, parent: parent
      )
      child5 = create(
        :post,
        title: 'Child w/o section 2', position: 10, published: true, section: nil, parent: parent
      )
      child6 = create(
        :post,
        title: 'Child w/o section 1', position: 9, published: true, section: nil, parent: parent
      )
      create(
        :post,
        title: 'Unpublished Child', position: 7, published: false, section: section2, parent: parent
      )
      create(
        :post,
        title: 'Different Parent Child',
        position: 5,
        published: false,
        parent: create(:post, title: 'Different Parent', position: 100_500, published: true)
      )

      result = method_call(parent)

      expect(result).to eq(
        [
          {
            id: child6.id,
            name: 'Child w/o section 1',
            type: 'post',
            link: '/parent-post/child-w-o-section-1'
          },
          {
            id: child5.id,
            name: 'Child w/o section 2',
            type: 'post',
            link: '/parent-post/child-w-o-section-2'
          },
          {
            id: section1.id,
            name: 'First Section',
            type: 'section',
            posts: [
              {
                id: child3.id,
                name: 'Child 3',
                type: 'post',
                link: '/parent-post/child-3'
              },
              {
                id: child4.id,
                name: 'Child 4',
                type: 'post',
                link: '/parent-post/child-4'
              }
            ]
          },
          {
            id: section2.id,
            name: 'Second Section',
            type: 'section',
            posts: [
              {
                id: parent.id,
                link: '/parent-post',
                name: 'Parent Post',
                type: 'post'
              },
              {
                id: child1.id,
                name: 'Child 1',
                type: 'post',
                link: '/parent-post/child-1'
              },
              {
                id: child2.id,
                name: 'Child 2',
                type: 'post',
                link: '/parent-post/child-2'
              }
            ]
          }
        ]
      )
    end

    context 'when given post is a Child' do
      it 'returns nil' do
        parent = create(:post)
        child = create(:post, parent: parent)

        expect(method_call(child)).to eq(nil)
      end
    end
  end
end
