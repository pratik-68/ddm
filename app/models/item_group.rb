class ItemGroup < ApplicationRecord
  belongs_to :item
  belongs_to :group
end
