class TimelineController < ApplicationController
  def index
    # Grab a set of flags submitted and group them by minutes
    @submitted_flags = SubmittedFlag.all.group_by { |sf| sf.updated_at.change(sec: 0) }
  end
end
