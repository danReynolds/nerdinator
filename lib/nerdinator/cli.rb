module Nerdinator
  class Cli < Thor
    def initialize(args = [], local_options = {}, config = {})
      super(args, local_options, config)
      @session = Nerdinator::Session.instance
      @config = Nerdinator::Config.instance
      @session.tree = @config.read || Hash.new
    end

    desc 'list',
         'list all namespaced tmuxinator sessions'
    def list
      @session.list
    end

    desc 'add [NAMESPACE]/NAME',
         'add tmuxinator config NAME to the specified namespace if provided, else to the top
          level namespace'
    def add(session_path)
      session_query = session_path.split('/')
      @session.add(session_query)

      @config.write(@session.tree)
      @config.link(session_query.last)
    end

    desc 'remove NAMESPACE/[NAME]',
         'remove config NAME from the NAMESPACE if provided, else recursively remove NAMESPACE'
    def remove(session_path)
      session_query = session_path.split('/')
      @session.remove(session_query)
      @config.write(@session.tree)
    end

    desc 'start NAMESPACE', 'start all tmux sessions under NAMESPACE using their tmuxinator configs'
    def start(session_path = String.new)
      session_query = session_path.split('/')
      puts(@session.leaves(session_query).uniq)
    end
  end
end
