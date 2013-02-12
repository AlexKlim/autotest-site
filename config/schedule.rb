require File.expand_path('../environment', __FILE__)

Timetable.all.each do |tt|

  days = tt.days
  days.delete(days[-1])

  every days.map(&:to_sym), at: tt.value do
    rake "auto_test:run HOST=#{Environment.current.first.name} P=#{tt.automatedtest.name}"
  end

end

every :day, at: '6:01pm' do
  rake 'auto_test:remove_tests'
end

every :day, at: '6:03pm' do
  rake 'auto_test:update_code'
end

every :day, at: '7:40am' do
  rake "auto_test:send_mail HOST=#{Environment.current.first.name}"
end

every :day, at: '7:43am' do
  rake 'auto_test:create_report'
end
