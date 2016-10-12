# Nerdinator

[Tmuxinator](https://github.com/tmuxinator/tmuxinator) makes it easy to run custom tmux sessions with your panes and windows set the exact way that you like them. Nerdinator makes it easy to start arbitrary groups of tmux sessions each with their own tmuxinator configuration.

## Installation

Install Tmuxinator and tmux first. Then do:

`gem install nerdinator`

## Usage

Place a `tmuxinator.yml` file in the root of each of your projects.

There are then 4 commands you can use:

1. `nerdinator add Projects/nerdinator`: scopes the tmuxinator configuration in the current directory to the Projects namespace and namespaces can be nested arbitrarily.

2. `nerdinator start Projects`: starts a tmux session for each configuration listed under the Projects namespace. `nerdinator start Projects/nerdinator`: Similarly starts only the tmux session for the nerdinator configuration.

3. `nerdinator remove Projects/nerdinator`: removes nerdinator from the Projects namespace. `nerdinator remove Projects`: removes all under the namespace.

4. `nerdinator list`: shows all the namespaces and their descendent configurations.

## Development

This project is actively under development and more features will be coming in the future. I really enjoyed how tmuxinator makes it easy to do complex things and this further level of indirection continues that spirit.

## Contributing

As the default gemspec suggests:

> Bug reports and pull requests are welcome on GitHub at https://github.com/danreynolds/nerdinator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

