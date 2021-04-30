json.extract! task, :id, :issue, :category, :ref, :tags, :solution, :created_at, :updated_at
json.url task_url(task, format: :json)
