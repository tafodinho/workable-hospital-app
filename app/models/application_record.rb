class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  paginates_per 30
  
end
