# frozen_string_literal: true

class PostFinder
  def initialize(params)
    @parent_slug = params[:parent_slug]
    @child_slug = params[:child_slug]
  end

  def call
    return parent_post unless @child_slug && @parent_slug

    parent_post.children.published.find_by!(slug: @child_slug)
  end

  private

  def parent_post
    Post.published.where(parent_id: nil).find_by!(slug: @parent_slug)
  end
end
