def get_changed
  Task.find(@task.id)
end

def find_task(id)
  Task.find(id)
end

def json_task(id_or_all)
  id_or_all == :all ? Task.all.to_json : Task.find(id_or_all).to_json
end

def response_status
  last_response.status
end

def response_body
  last_response.body
end

def neg_task_scope(hash)
  Task.where.not(hash)
end

def make_request(method, path, string=nil)
  case method
  when 'POST'
    post path, string, 'CONTENT-TYPE' => 'application/json'
  when 'PUT'
    put path, string, 'CONTENT-TYPE' => 'application/json'
  when 'GET'
    get path
  when 'DELETE'
    delete path 
  end
end