class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search_results
    @search_result_projects = []
    search_fields = ['name', 'category', 'status_project', 'tags']

    params.each do |key, value|
      next if !search_fields.include?(key) || value == "" || value.nil?

      if key.to_s == "tags"
        Project.search_by_tag(value).each do |element|
          @search_result_projects << element
        end
        next
      end

      Project.global_search(key.to_sym, value).each do |element|
        @search_result_projects << element
      end
    end
    @search_result_projects.uniq!
  end
end
