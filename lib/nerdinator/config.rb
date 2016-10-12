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

    def read(file = root)
      YAML.load_file(file)
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
      File.symlink(local, "#{tmuxinator_root}/#{name}.yml")
    end
  end
end
