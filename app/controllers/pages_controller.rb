# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @posts = Post.published.parents.order(position: :asc)
  end

  def mounted_to_root; end
end
