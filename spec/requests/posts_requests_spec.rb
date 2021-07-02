# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #show' do
    let(:parent) { create(:post) }
    let(:child) { create(:post, parent: parent) }

    context 'when /parent-post' do
      it 'responds with 200' do
        child # create child post

        get "/#{parent.slug}"

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("<nav class='toc'") # ensure ToC rendering
      end
    end

    context 'when /child-post' do
      it 'responds with 404' do
        expect { get "/#{child.slug}" }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
