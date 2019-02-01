class TeamTechnology < ApplicationRecord
  belongs_to :team
  belongs_to :technology, optional: true
  accepts_nested_attributes_for :technology, reject_if: :all_blank
end
