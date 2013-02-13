# Web application

Web application for autotest with cucumber and mercurial. You can change to git or smth else.
It is only example, feel free to change code as you like.

## Installation

    git clone https://github.com/AlexKlim/autotest-site.git
    cd autotest-site
    bundle install
    rake db:create
    rake db:migrate
    rake db:seed (if need, check db/seeds.rb file)
    rails s

## Usage

Create clone repo and don't forget change config file (config/config.yml, create if not exist). Use config.example.yml as example.

test_folder - folder which contain your test's report.

auto_test - folder for your cucumber tests


If you will use 'Timetable', then you can change Rakefile.

    rake update:tags   
task will look in .hgtags file and create new records to db. Change parser for tag (tag = line[/release_.*/]).

    rake update:tests 
task will look into ~/path/to/auto_test/features/fuctionality folder, and update records for Automatedtests.

    rake update:code 
task will invoke 'hg pull --rebase && hg update' into 'auto_test' folder.

    rake auto_test:remove_tests
task will remove all '*.erb' file from 'auto_test' folder. It is necessary, that our list-report has actually report. Need run the task before rake auto_test:run

    rake auto_test:run
task will run nightly tests

    rake auto_test:create_report
task will create report: copy '*.erb' files from 'auto_test' folder to 'test_folder'. We can see all reports in the root page.

    rake auto_test:send_mail
task will send report, if you want.


All tasks from 'auto_test' namespace you can add/remove to schedule.rb file. I think, the best way, to add rake auto_test:remove_tests before all nightly tests, and rake auto_test:send_mail after all tests.