class TimeTableSet
  extend ActiveModel::Naming

  attr_accessor :timetables

  def initialize(params = nil)
    initialize_from_params(params) unless params.nil?
  end

  def save!
    ActiveRecord::Base.transaction do
      timetables.each(&:save!)
    end
  end

  def timetables
    @timetables ||= []
  end

  private
  def initialize_from_params(params)
    params[:timetables].each do |k, v|
      timetable = Timetable.find(k)

      temp = {}
      temp.merge! v['days']
      temp.merge! value: v['value']

      timetable.attributes = temp
      timetables << timetable
    end
  end

end
