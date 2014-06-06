class TalkSuggestion < ActiveRecord::Base
  attr_accessible :created_by_id, :description, :name, :style, :suggested_speaker

  belongs_to :created_by, class_name: "User"

  def self.talk_suggestions
    ["Full Talk (30-45 min)", "Short Talk (15-30 min)", "Lightning (5 min)"]
  end

  def vote_count
    read_attribute(:vote_count) || 0
  end
end
