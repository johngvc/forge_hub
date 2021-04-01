class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search_results
    @search_result_projects = search(Project, {
                                       against_arg: [
                                         'name',
                                         'category',
                                         'status_project'
                                       ],
                                       associated_model: 'tags',
                                       associated_against_arg: [
                                         'name'
                                       ],
                                       filter_against_arg: {
                                         project_name: 'name',
                                         category: 'category',
                                         status_project: 'status_project'
                                       },
                                       filter_associated_model: 'tags',
                                       filter_associated_against_arg: {
                                         tag_name: 'name'
                                       }
                                     })
    @search_result_users = search_users
  end

  private

  def search(model_to_search, search_params = {})
    # filters passed for filter_against and filter_assoociated_against should be formated as
    # key = <param_name>
    # value = <table_column_name>
    search_result_associated_against = []
    search_result_against = []
    search_result = []

    # Get necessary info from parameters
    search_params[:against_arg].each do |value|
      against_arr << value.to_sym
    end

    search_params[:associated_against_arg].each do |value|
      associated_against_arr << value.to_sym
    end

    # Do the base search
    unless search_params[:associated_model].nil?
      model_to_search.global_search_association(associated_against_arr, search_params[:associated_model],
                                                params[:global_query]).each do |results_element|
                                                  search_result_association << results_element
                                                end
    end
    model_to_search.global_search(against_arr, params[:global_query]).each do |results_element|
      search_result_against << results_element
    end

    search_result = search_result_associated_against & search_result_against

    # Apply filters if provided
    unless search_params[:filter_associated_model].nil? && search_params[:filter_associated_against_arg].nil?
      # Do the filtering on the base search result
      search_params[:filter_associated_against_arg].each do |params_name, table_column_name|
        search_result.global_search_association(table_column_name, search_params[:filter_associated_model],
                                                params[params_name.to_sym])
      end
    end

    unless search_params[:filter_against_arg].nil?
      # Do the filtering on the base search result
      search_params[:filter_against_arg].each do |params_name, table_column_name|
        search_result.global_search(table_column_name, params[params_name.to_sym])
      end
    end

    # Return search
    return search_result
  end
end
