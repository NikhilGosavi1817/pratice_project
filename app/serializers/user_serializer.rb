class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :age, :date_of_birth, :email, :created_at
end
