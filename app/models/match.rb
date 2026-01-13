class Match < ApplicationRecord
  belongs_to :winner, class_name: "Player"
  belongs_to :loser, class_name: "Player"

  validates :winner_id, presence: true
  validates :loser_id, presence: true
  validate :players_must_be_different

  private

  def players_must_be_different
    if winner_id == loser_id
      errors.add(:base, "Winner and loser must be different players")
    end
  end
end
