class Todo < ActiveRecord::Base
  belongs_to :users
  attr_reader :id, :title, :label, :user_id, :is_done, :created_at, :updated_at
end
