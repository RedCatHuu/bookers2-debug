class UserGroup < ApplicationRecord
  belongs to :user
  belongs to :group
end
