require 'fog'

desc 'Deploy Ember and Rails'
task :deploy do
end

namespace :deploy do
  desc 'Build and Deploy Ember'
  task :ember do
    sh 'cd ember; ember build --environment production --output-path production/'

    service = Fog::Storage.new(provider: 'Rackspace',
                               rackspace_username: 'tyrbo', 
                               rackspace_api_key: ENV['RACKSPACE_API'], 
                               rackspace_region: :dfw)

    directory = service.directories.new key: 'tunefish'
    Dir.glob('ember/production/assets/*').each do |f|
      name = Pathname.new(f).basename
      puts "Uploading... #{name}"
      directory.files.create key: "assets/#{name}", body: File.open(f)
    end

    sh 'cd ember/production; scp index.html root@balancer.tunefi.sh:/var/www'
  end

  namespace :rails do
    desc 'Rolling deployment'
    task :rolling do
    end

    desc 'Hard deployment'
    task :hard do
      sh 'cd rails; docker build -t tyrbo/tunefish . && docker push tyrbo/tunefish'
      raw = `fleetctl --tunnel=104.131.171.238 list-units --no-legend --fields=unit`.split("\n")
      units = raw.select { |x| x =~ /[rails|sidekiq]@[0-9]+.service/ }

      begin
        sh "fleetctl --tunnel=104.131.171.238 stop rails-starter.service #{units.join(' ')}"
      rescue
        puts "Unable to stop fleet services..."
      end

      sh "fleetctl --tunnel=104.131.171.238 start rails-starter.service #{units.join(' ')}"
    end
  end
end
