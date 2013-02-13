require 'net/http'
require 'uri'

class UserMailer < ActionMailer::Base
  default from: Autotest::CONFIG.mail_from

  def send_email
    host = Environment.current.first.name
    body = "Result Report for\n\n#{scenarios}"

    mail(to: Autotest::CONFIG.mail_recipient, subject: Autotest::CONFIG.mail_subject, body: body)
  end

  private
  
  def scenarios
    scenarios = ''
    path = File.expand_path(Autotest::CONFIG.auto_test)
    Dir.new(path).each do |file|
      if File.extname(file) == '.erb'
        doc = Nokogiri::HTML(open("#{path}/#{file}"))
        length = doc.xpath('//script[@type="text/javascript"]').length
        scenarios += "* #{file.split('.')[0].capitalize}: "

        begin
          scenarios += doc.xpath('//script[@type="text/javascript"]')[length -1].content[/(\d*) scenarios (.*)</][0..-2]
        rescue
        end

        scenarios += "\n"
      end
    end

    scenarios
  end

end
