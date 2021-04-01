class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search_results
    @search_result_projects = search_projects(Project, {
                                                against__params_name_table_column: {
                                                  project_name: 'name',
                                                  category: 'category',
                                                  status_project: 'status_project'
                                                },
                                                associated_model: 'tags',
                                                associated_against__params_name_table_column: {
                                                  tag_name: 'name'
                                                }
                                              })
    @search_result_users = search_users
  end

  private

  def search(model_to_search, search_params = {})
    search_params[:against__params_name_table_column].each do |_key, value|
      against_arr << value
    end

    search_params[:associated_against__params_name_table_column].each do |_key, value|
      associated_against_arr << value
    end

    unless search_params[:associated_model].nil?
      model_to_search.global_search_association(associated_against_arr, search_params[:associated_model],
                                                association_query)
    end
    model_to_search.global_search(against_arr, query)
  end
end
