class Thynkup < ActiveRecord::Base
  belongs_to :user, inverse_of: :thynkups
  belongs_to :thynker, class_name: :user
end
