# frozen_string_literal: true

class TocBuilder
  include Rails.application.routes.url_helpers

  def initialize(post)
    @post = post
  end

  def call
    return unless @post.parent?

    # Perhaps it is not a good idea to display ToC for just a single post
    return if posts.count < 2

    [
      sectionless_posts.map { |post| represented_post(post) },
      sections.map { |section| represented_section(section) }.compact
    ].flatten
  end

  private

  def sectionless_posts
    posts.sectionless.order(position: :asc)
  end

  def posts
    @posts ||=
      Post
      .where(id: @post.id)
      .or(
        Post.where(id: @post.children.published)
      )
      .order(position: :asc)
  end

  def sections
    @post.sections.includes(:posts).order(position: :asc)
  end

  def represented_section(section)
    # Perhaps it is not a good idea to display a Section w/o posts
    return nil unless section.posts.any?

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
    link = post.parent? ? parent_post_path(post.slug) : child_post_path(@post.slug, post.slug)

    {
      id: post.id,
      name: post.title,
      type: 'post',
      link: link
    }
  end
end
