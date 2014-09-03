class ScoreAdjustment < FeedItem
  
  include ActionView::Helpers::TextHelper
  
  validates :point_value, :text, presence: true
  validate :point_value_is_not_zero
  
  def description
    color = ""
    verb = ""
    points = self.point_value
    if points < 0
      color = "red"
      verb = "decreased"
    else
      color = "green"
      verb = "increased"
    end
    %[Score was #{verb} by <span style="color:#{color};">#{pluralize(points.abs, "point")}</span>]
  end
  
  def icon
    (self.point_value < 0) ? "chevron-down" : "chevron-up"
  end
  
  def point_value_is_not_zero
    if self.point_value == 0
      errors.add(:point_value, "must not be zero.")
    end
  end
  
end
