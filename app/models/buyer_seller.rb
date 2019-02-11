class BuyerSeller < ActiveRecord::Base
  # AR classes are singular and capitalized by convention
  belongs_to :house
end