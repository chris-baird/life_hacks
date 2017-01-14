class Comment < ActiveRecord::Base
  belongs_to :hack
  belongs_to :user
end
