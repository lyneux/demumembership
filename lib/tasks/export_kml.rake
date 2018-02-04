desc "Exports the ag data as kml"
task :export_kml => :environment do
  require 'rest-client'
  require 'json'
  require 'ruby_kml'

  kml = KMLFile.new


  folder = KML::Folder.new(:name => "Members")

  AreaGroup.all.each do |ag|

    ag_folder = KML::Folder.new(:name => ag.name)

    folder.features << ag_folder

    ag.members.each do |member|
      unless member.contact_details.nil? || member.contact_details.postcode.nil?
        postcode = member.contact_details.postcode.delete(' ')
        puts postcode + ": "

        begin
          #Previously used:
          #data = RestClient.get 'http://uk-postcodes.com/postcode/' + postcode + '.json'
          data = RestClient.get 'http://api.postcodes.io/postcodes/' + postcode
          jsonresult = JSON.parse(data)
          #puts jsonresult['result']['latitude'].to_s
          #puts jsonresult['result']['longitude'].to_s

          ag_folder.features << KML::Placemark.new(
            :name => member.forename + " " + member.surname,
            :geometry => KML::Point.new(:coordinates => {:lat => jsonresult['result']['latitude'], :lng => jsonresult['result']['longitude']})
          )


        rescue => e
          #e.response
          puts 'Data for postcode: ' + postcode + ' not found.'
        end
        
      end
    end
    
  end
  kml.objects << folder
  
  File.write('members.kml', kml.render)

end