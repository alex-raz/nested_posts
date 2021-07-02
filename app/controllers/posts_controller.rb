# frozen_string_literal: true

class PostsController < ApplicationController
  def show
    @post = PostFinder.new(params).call
    @toc = TocBuilder.new(@post).call
  end
end
