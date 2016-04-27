class MPost
  include Mongoid::Document

  field :title,  type: String
  field :author, type: String
  field :views,  type: Integer
  field :opts,   type: Array
  field :not_exists, type: Boolean
end
