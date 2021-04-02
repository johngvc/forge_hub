class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search_results
    @search_result_projects = search(Project, {
                                       against_arg: [
                                         'name',
                                         'description',
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
    # @search_result_users = search_users
  end

  private

  def search(model_to_search, search_params = {})
    # filters passed for filter_against and filter_assoociated_against should be formated as
    # key = <param_name>
    # value = <table_column_name>
    search_result_associated_against = []
    search_result_against = []
    against_arr = []
    associated_against_arr = []

    # Get necessary info from parameters
    search_params[:against_arg].each do |value|
      against_arr << value.to_sym
    end

    search_params[:associated_against_arg].each do |value|
      associated_against_arr << value.to_sym
    end

    # Do the base search
    # if global_query is absent, search the filters selected
    if params[:global_query] == "" || params[:global_query].nil?
      search_results_arr = []
      tmp_result_arr = []

      search_params[:filter_associated_against_arg].each do |params_name, table_column_name|
        next if params[params_name.to_sym].nil? || params[params_name.to_sym] == ""

        params[params_name.to_sym].split('`').each do |value_to_search|
          model_to_search.global_search_association([table_column_name.to_sym], search_params[:filter_associated_model],
                                                    value_to_search).each do |result|
            tmp_result_arr << result
          end
          search_results_arr << tmp_result_arr
          tmp_result_arr = []
        end
      end

      search_params[:filter_against_arg].each do |params_name, table_column_name|
        next if params[params_name.to_sym].nil? || params[params_name.to_sym] == ""

        params[params_name.to_sym].split('`').each do |value_to_search|
          model_to_search.global_search([table_column_name.to_sym],
                                        value_to_search).each do |result|
            tmp_result_arr << result
          end
          search_results_arr << tmp_result_arr
          tmp_result_arr = []
        end
      end

      return search_results_arr.reduce(:&)
    end
    # if global_query is present, search the it as the base search to apply the filters
    unless search_params[:associated_model].nil?
      search_result_association_against = model_to_search.global_search_association(associated_against_arr, search_params[:associated_model],
                                                                                    params[:global_query])
    end
    search_result_against = model_to_search.global_search(against_arr, params[:global_query])

    # Apply filters if provided
    # Do the filtering on the base search result
    search_params[:filter_associated_against_arg].each do |params_name, table_column_name|
      next if params[params_name.to_sym].nil? || params[params_name.to_sym] == ""

      params[params_name.to_sym].split('`').each do |value_to_search|
        search_result_association_against = search_result_association_against.global_search_association([table_column_name.to_sym], search_params[:filter_associated_model],
                                                                                                        value_to_search)

        search_result_against = search_result_against.global_search_association([table_column_name.to_sym], search_params[:filter_associated_model],
                                                                                value_to_search)
      end
    end

    # Do the filtering on the base search result
    search_params[:filter_against_arg].each do |params_name, table_column_name|
      next if params[params_name.to_sym].nil? || params[params_name.to_sym] == ""

      params[params_name.to_sym].split('`').each do |value_to_search|
        search_result_against = search_result_against.global_search([table_column_name.to_sym],
                                                                    value_to_search)
        search_result_association_against = search_result_association_against.global_search([table_column_name.to_sym],
                                                                                            value_to_search)
      end
    end

    # Return search
    search_result_association_against_arr = []
    search_result_against_arr = []
    search_result_association_against.each do |element|
      search_result_association_against_arr << element
    end
    search_result_against.each do |element|
      search_result_against_arr << element
    end

    return search_result_association_against_arr | search_result_against_arr
  end
end
