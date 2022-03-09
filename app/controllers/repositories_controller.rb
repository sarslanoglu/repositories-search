# frozen_string_literal: true

# Repository index for search
class RepositoriesController < ApplicationController
  def index
    @total_result = 0
    @total_pages = 0

    if search_params['query'].present?
      response = RepoFetcher.new(query: search_params['query'], page_number: search_params['page']).fetch_public_repos

      view_result(response)
    else
      @is_empty_state = true
    end
  end

  private

  def search_params
    params.permit(:query,
                  :page)
  end

  def view_result(response)
    case response[:status]
    when 'success'
      @is_github_down = false
      @default_per_page = response[:default_per_page]
      @selected_page = response[:selected_page]
      @total_result = response[:total_result]
      @total_pages = response[:total_pages]
      @repositories = response[:repositories]
    when 'limit_reached'
      @is_limit_reached = true
    when 'failure'
      @is_github_down = true
    end
  end
end
