class UserSerializer < ApplicationSerializer
  attributes :first_name, :last_name, :mobile_number, :address, :email,
             :type_of_user, :invite_count, :last_invite_at
end
