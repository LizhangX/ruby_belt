class Like < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :idea, required: true

  
end
