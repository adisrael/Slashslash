json.extract! publication, :id, :title, :content, :user_id, \
              :forum_id, :created_at, :updated_at
json.url publication_url(publication, format: :json)
