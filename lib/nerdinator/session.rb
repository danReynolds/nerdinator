module Nerdinator
  class Session
    include Singleton
    attr_accessor :tree

    def list(tree = @tree, spacing = '')
      tree.to_a.each do |session, subtree|
        if subtree.keys.length.zero?
          puts "#{spacing}#{session}"
        else
          puts "#{spacing}#{session}:"
          list(subtree, "#{spacing}  ")
        end
      end
    end

    def add(session_query, tree = @tree)
      tree[session_query.first] ||= {}
      if session_query.length > 1
        session = session_query.shift
        add(session_query, tree[session])
      end
    end

    def remove(session_query, tree = @tree)
      if session_query.length > 1
        session = session_query.shift
        remove(session_query, tree[session])
        tree.delete(session) if tree[session].keys.length.zero?
      else
        tree.delete(session_query.first)
      end
    end

    def leaves(session_query, tree = @tree)
      if session_query.length.zero?
        tree.inject([]) do |acc, (session, subtree)|
          sub_leaves = leaves([], subtree)
          if sub_leaves.empty?
            acc << session
          else
            acc += sub_leaves
          end
        end
      else
        session = session_query.shift
        sub_leaves = leaves(session_query, tree[session])
        if sub_leaves.empty?
          [session]
        else
          sub_leaves
        end
      end
    end
  end
end
