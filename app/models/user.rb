class User < ApplicationRecord
     belongs_to :game, optional: true
#has_one :game
end
