require 'sinatra'
require 'sinatra/activerecord'
require 'acts_as_list'
require 'json'
require 'require_all'
require_all 'models'
require_all 'helpers'
require_all 'controllers'

class Canto < Sinatra::Application
  set :database_file, 'config/database.yml'
  set :data, ''

  get '/tasks' do 
    begin_and_rescue(ActiveRecord::RecordNotFound, 404) do 
      content_type :json
      params[:complete] ? interpret_complete_param(params[:complete]) : Task.all.to_json
    end
  end

  post '/tasks' do 
    begin_and_rescue(ActiveRecord::RecordInvalid, 422) { create_task(request_body); 201 }
  end

  get '/tasks/:id' do |id|
    begin_and_rescue(ActiveRecord::RecordNotFound, 404) { get_task(id) }
  end

  put '/tasks/:id' do |id|
    begin_and_rescue(ActiveRecord::RecordInvalid, 422) { update_task(id, request_body); 200 }
  end

  delete '/tasks/:id' do |id|
    begin_and_rescue(ActiveRecord::RecordNotFound, 404) { delete_task(id); 204 }
  end
end