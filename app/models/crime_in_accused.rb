class CrimeInAccused < ApplicationRecord
  belongs_to :crime
  belongs_to :person
end
