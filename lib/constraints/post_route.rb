# frozen_string_literal: true

class PostRoute
  def self.matches?(request)
    Post.where(
      slug: [
        request.params[:parent_slug],
        request.params[:child_slug]
      ]
    ).any?
  end
end
