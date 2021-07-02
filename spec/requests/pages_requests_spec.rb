# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  describe 'GET #home' do
    it 'responds with 200' do
      create(:post, title: 'Parent Post')

      get '/'

      expect(response).to have_http_status(:ok)
      body = response.body
      expect(body).to include('<h1>Nested Posts</h1>')
      expect(body).to include('Parent Post')
    end
  end
end
