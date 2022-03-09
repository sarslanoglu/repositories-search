# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepositoriesController, type: :controller do
  describe 'GET index' do
    it 'should return success result' do
      VCR.use_cassette('github_public_repository_search') do
        get :index, params: { query: 'something', page: 1 }
        expect(response).to be_successful
      end
    end
  end
end
