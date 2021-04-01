class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def search_results
    @search_result = []
    search_result_projects_arr = []
    search_result_users_arr = []
    @type_choosen = ""

    if params[:type_filter] == "users"
      @search_result = search_users
      @type_choosen = "users"
    elsif params[:type_filter] == "projects"
      @search_result = search_projects
      @type_choosen = "projects"
    else
      search_result_projects_arr = search_projects
      search_result_users_arr = search_users

      if search_result_projects_arr.length >= search_result_users_arr.length
        @search_result = search_result_projects_arr
        @type_choosen = "projects"
      else
        @search_result = search_result_users_arr
        @type_choosen = "users"
      end
    end
  end

  private

  def search_projects
    search_result_projects = []
    search_fields_params = ['project_name', 'category', 'status_project', 'tags']
    search_fields_table_columns = %i[name description status_project category]
    if params[:type_filter] == "" || params[:type_filter].nil?
      Project.search_by_tag(params[:search_arg]).each do |element|
        search_result_projects << element
      end

      Project.global_search(search_fields_table_columns, params[:search_arg]).each do |element|
        search_result_projects << element
      end
      return search_result_projects.empty? ? [] : search_result_projects.uniq

    end

    params.each do |key, value|
      next if !search_fields_params.include?(key) || value == "" || value.nil?

      if key.to_s == "tags"
        Project.search_by_tag(value).each do |element|
          search_result_projects << element
        end
        next
      end

      Project.global_search(key == "project_name" ? [:name] : [key.to_sym], value).each do |element|
        search_result_projects << element
      end
    end
    return search_result_projects.empty? ? [] : search_result_projects.uniq
  end

  def search_users
    search_result_users = []
    search_fields_params = ["user_name", "first_name", "last_name", "specialties"]
    search_fields_table_columns = %i[name first_name last_name]

    if params[:type_filter] == "" || params[:type_filter].nil?
      User.search_by_specialty(params[:search_arg]).each do |element|
        search_result_users << element
      end

      User.global_search(search_fields_table_columns, params[:search_arg]).each do |element|
        search_result_users << element
      end
      return search_result_users.empty? ? [] : search_result_users.uniq

    end

    params.each do |key, value|
      next if !search_fields_params.include?(key) || value == "" || value.nil?

      if key.to_s == "specialties"
        User.search_by_specialty(value).each do |element|
          search_result_users << element
        end
        next
      end

      User.global_search(key == "user_name" ? [:name] : [key.to_sym], value).each do |element|
        search_result_users << element
      end
    end
    return search_result_users.empty? ? [] : search_result_users.uniq
  end
end
