require 'net/http'
require 'uri'

class UserMailer < ActionMailer::Base
  default from: Autotest::CONFIG.mail_from
  PATH = File.expand_path(Autotest::CONFIG.auto_test)

  def send_email
    body = "Result Report for\n\n#{scenarios}"
    mail(to: Autotest::CONFIG.mail_recipient, subject: Autotest::CONFIG.mail_subject, body: body)
  end

  def send_separate_report(host, test)
    report = "#{host}_#{test}_report.erb"
    body = "\n\nResult Report for\n\n#{separate_scenario(report)}"
    attachments[report] = File.read("#{Autotest::CONFIG.test_folder}/#{report}")
    mail(to: Autotest::CONFIG.mail_recipient, subject: Autotest::CONFIG.mail_subject, body: body)
  end

  private
  
  def scenarios
    scenarios = ''  
    Dir.new(PATH).each do |file|
      if File.extname(file) == '.erb'
        doc = Nokogiri::HTML(open("#{PATH}/#{file}"))
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

  def separate_scenario(report)
    scenario = ''
    doc = Nokogiri::HTML(open("#{PATH}/#{report}"))
    length = doc.xpath('//script[@type="text/javascript"]').length
    scenario += "* #{report.split('.')[0].capitalize}: "

    begin
      scenario += doc.xpath('//script[@type="text/javascript"]')[length -1].content[/(\d*) scenarios (.*)</][0..-2]
    rescue
    end

    scenario
  end

end
