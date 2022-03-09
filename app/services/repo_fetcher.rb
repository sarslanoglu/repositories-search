# frozen_string_literal: true

require 'faraday'

# Repo fetching service for public repositories
class RepoFetcher
  def initialize(query:, page_number:)
    @query = query
    @page_number = page_number
  end

  def fetch_public_repos
    result = {}

    result[:selected_page] = @page_number.present? ? @page_number : 1

    response = api_request(@query, result[:selected_page])

    if response.present? && response.status == 200
      parsed_response = JSON.parse(response.body)

      result[:default_per_page] = 30
      result[:total_result] = parsed_response['total_count']
      result[:total_pages] = (result[:total_result].to_f / result[:default_per_page]).ceil
      result[:repositories] = parsed_response['items']

      result[:status] = 'success'
    elsif response.present? && response.status == 422 &&
          JSON.parse(response.body)['message'] == 'Only the first 1000 search results are available'
      result[:status] = 'limit_reached'
    else
      # API can also return 304, 503. For simplicity all these responses are considered as failure
      result[:status] = 'failure'
    end

    result
  end

  private

  def api_request(query, page)
    url = 'https://api.github.com/search/repositories'
    Faraday.get(url, { q: query, page: page })
  end
end
