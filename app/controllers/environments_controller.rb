class EnvironmentsController < ApplicationController

  def create
    Environment.all.each do |env|
      env.current = false
      env.current = true if env.name == params[:environment][:current]
      env.save!      
    end

    Timetable.send_cron_later
    redirect_to edit_timetables_path
  end  

end