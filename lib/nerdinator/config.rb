module Nerdinator
  class Config
    include Singleton

    SETTINGS_KEY = 'nerdinator'.freeze

    def tmuxinator_root
      File.expand_path("#{ENV['HOME']}/.tmuxinator")
    end

    def root
      File.expand_path("#{ENV['HOME']}/.nerdinator/nerdinator.yml")
    end

    def local
      File.expand_path("#{ENV['PWD']}/tmuxinator.yml")
    end

    def setup(path)
      Dir.mkdir(path.split('/')[0...-1].join('/'))
      File.write(path, '')
    end

    def read(path = root)
      setup(path) unless File.exists?(path)
      YAML.load_file(path)
    end

    def write(data)
      File.open(root, 'w+') do |f|
        YAML.dump(data, f)
      end
    end

    def parse_settings(data)
      if settings = data[SETTINGS_KEY]
        settings.map { |k, v| "#{k}=#{v}" }.join(' ')
      end
    end

    def tmuxinator_command(session, settings)
      %x[tmuxinator start #{session} #{settings}]
    end

    def start(sessions)
      puts 'Nerdinator Sessions started:'
      sessions.each do |session|
        puts "#{session}"
        settings = parse_settings(read("#{tmuxinator_root}/#{session}.yml"))
        tmuxinator_command(session, settings)
      end
    end

    def link(name)
      path = "#{tmuxinator_root}/#{name}.yml"
      File.symlink(local, path) unless File.symlink?(path)
    end
  end
end
