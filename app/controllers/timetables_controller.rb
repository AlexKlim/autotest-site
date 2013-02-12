class TimetablesController < ApplicationController

  before_filter :init

  def edit  
    @timetables_set.timetables = Timetable.all
  end

  def update
    @timetables_set.save!
    Timetable.send_cron_later
    redirect_to edit_timetables_path
  end

  private

  def init
    puts params
    @timetables_set = TimeTableSet.new(params[:timetables_set])
  end

end
