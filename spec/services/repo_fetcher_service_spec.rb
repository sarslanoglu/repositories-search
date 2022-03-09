# frozen_string_literal: true

require 'rails_helper'

# In all cases user views some visual information about status of call. None of them should raise an error
RSpec.describe RepoFetcher do
  describe 'request public repositories' do
    context 'should return success result' do
      it 'when services up and running' do
        VCR.use_cassette('github_public_repository_search') do
          expect { described_class.new(query: 'something', page_number: 1).fetch_public_repos }.to_not(raise_error)
        end
      end
    end

    context 'should return limit reached result' do
      before do
        Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get('/') { |_env| [422, {}, 'error'] }
        end
      end

      it 'when user requested more results' do
        VCR.use_cassette('github_public_repository_search') do
          expect { described_class.new(query: 'something', page_number: 1).fetch_public_repos }.to_not(raise_error)
        end
      end
    end

    context 'should return failure result' do
      before do
        Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get('/') { |_env| [500, {}, 'internal_error'] }
        end
      end

      it 'when user requested more results' do
        VCR.use_cassette('github_public_repository_search') do
          expect { described_class.new(query: 'something', page_number: 1).fetch_public_repos }.to_not(raise_error)
        end
      end
    end
  end
end
