class User < ApplicationRecord
  include Clearance::User
  has_many :ticket_groups


end
