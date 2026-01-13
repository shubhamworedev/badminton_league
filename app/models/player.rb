class Player < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :wins, class_name: "Match", foreign_key: :winner_id, dependent: :destroy
  has_many :losses, class_name: "Match", foreign_key: :loser_id, dependent: :destroy

  def wins_count
    wins.count
  end

  def losses_count
    losses.count
  end
end
