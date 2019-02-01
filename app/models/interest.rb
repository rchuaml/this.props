class Interest < ApplicationRecord
  belongs_to :user
  belongs_to :house
end


# Query the houses that a certain user is interested in:

# House.where(id: Interest.where(user_id: certainuser.id))