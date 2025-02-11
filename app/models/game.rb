# == Schema Information
#
# Table name: games
#
#  id           :uuid             not null, primary key
#  date         :datetime
#  notes        :string
#  status       :integer          default("awaiting")
#  team_a_score :integer          default(0)
#  team_b_score :integer          default(0)
#  winner_team  :integer          default("no_team"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  group_id     :uuid             not null
#  owner_id     :uuid             not null
#  place_id     :uuid             not null
#
# Indexes
#
#  index_games_on_group_id  (group_id)
#  index_games_on_owner_id  (owner_id)
#  index_games_on_place_id  (place_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (owner_id => users.id)
#  fk_rails_...  (place_id => places.id)
#
class Game < ApplicationRecord
  belongs_to :place
  belongs_to :group
  belongs_to :owner, class_name: 'User'

  has_many :game_players, dependent: :restrict_with_error
  has_many :players, through: :game_players

  enum status: [:awaiting, :processing, :finished], _default: :awaiting
  enum winner_team: [:no_team, :a, :b], _default: :no_team

  def can_proccess?
    awaiting? && date < Time.zone.now
  end
end
