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

    describe 'corner cases' do
      describe 'empty ToC' do
        specify 'when given post is a Child' do
          parent = create(:post)
          child = create(:post, parent: parent)

          expect(method_call(child)).to eq(nil)
        end

        specify 'post that belongs to a Parent Section without child posts and sections' do
          parent = create(:post, title: 'Parent Post', position: 1, published: true)
          section2 = create(:section, post: parent, name: 'Second Section', position: 2)
          parent.update(section: section2) # add parent post to the second section

          result = method_call(parent)

          expect(result).to eq(nil)
        end

        specify 'standalone post' do
          parent = create(:post, title: 'Parent Post', position: 1, published: true)

          result = method_call(parent)

          expect(result).to eq(nil)
        end
      end

      specify 'section(s) w/o posts inside them' do
        parent = create(:post, title: 'Parent Post', position: 1, published: true)
        child1 = create(
          :post, title: 'Child 1', position: 2, published: true, parent: parent
        )
        create(:section, post: parent, name: 'First Section', position: 1)
        create(:section, post: parent, name: 'Second Section', position: 2)

        result = method_call(parent)

        expect(result).to eq(
          [
            {
              id: parent.id,
              link: '/parent-post',
              name: 'Parent Post',
              type: 'post'
            },
            {
              id: child1.id,
              link: '/parent-post/child-1',
              name: 'Child 1',
              type: 'post'
            }
          ]
        )
      end

      specify 'accidental section destroying' do
        parent = create(:post, title: 'Parent Post', position: 1, published: true)
        section2 = create(:section, post: parent, name: 'Second Section', position: 2)
        parent.update(section: section2) # add parent post to the second section
        child1 = create(
          :post, title: 'Child 1', position: 2, published: true, section: section2, parent: parent
        )
        # inital ToC state
        expect(method_call(parent)).to eq(
          [
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
                  link: '/parent-post/child-1',
                  name: 'Child 1',
                  type: 'post'
                }
              ]
            }
          ]
        )

        section2.destroy

        expect(method_call(parent)).to eq(
          [
            {
              id: parent.id,
              link: '/parent-post',
              name: 'Parent Post',
              type: 'post'
            },
            {
              id: child1.id,
              link: '/parent-post/child-1',
              name: 'Child 1',
              type: 'post'
            }

          ]
        )
      end

      # (though technically this spec belongs to the Model layer)
      # I decided to leave it here to keep all the known 'corner cases' in a single place
      specify 'accidental parent post destroying' do
        parent = create(:post, title: 'Parent Post', position: 1, published: true)
        section2 = create(:section, post: parent, name: 'Second Section', position: 2)
        parent.update(section: section2) # add parent post to the second section
        create(
          :post, title: 'Child 1', position: 2, published: true, section: section2, parent: parent
        )

        parent.destroy

        expect(Section.find_by(name: 'Second Section')).to be_persisted
        expect(Post.find_by(title: 'Child 1')).to be_persisted
        expect(parent.errors.first.full_message).to eq('You may not delete this Parent Post.')
      end
    end
  end
end
