class CrimeInAccused < ApplicationRecord
  belongs_to :crime
  belongs_to :person
  belongs_to :procedure
end
