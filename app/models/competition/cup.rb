# frozen_string_literal: true

class Competition
  class Cup < Competition
    scope :active, (-> { where(active: true) })
  end
end
