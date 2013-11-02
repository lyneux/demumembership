desc "Imports the CMS data"
task :import_cms_data => :environment do

  ActiveRecord::Base.connection.execute(IO.read("lib/tasks/cmsdata.sql"))

end