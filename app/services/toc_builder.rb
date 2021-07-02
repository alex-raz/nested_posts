# frozen_string_literal: true

class TocBuilder
  include Rails.application.routes.url_helpers

  def initialize(post)
    @post = post
  end

  def call
    return unless @post.parent?

    [
      sectionless_posts.map { |post| represented_post(post) },
      sections.map { |section| represented_section(section) }
    ].flatten
  end

  private

  def sectionless_posts
    @post.children.published.sectionless.order(position: :asc)
  end

  def sections
    @post.sections.includes(:posts).order(position: :asc)
  end

  def represented_section(section)
    {
      id: section.id,
      name: section.name,
      type: 'section',
      posts: section_posts(section).map { |post| represented_post(post) }
    }
  end

  def section_posts(section)
    section.posts.published.order(position: :asc)
  end

  def represented_post(post)
    {
      id: post.id,
      name: post.title,
      type: 'post',
      link: child_post_path(@post.slug, post.slug)
    }
  end
end
