require 'me2day/identity'

module Me2day
  class BasicPerson < Me2day::Identity
    attr_reader :me2dayHome, :realname, :homepage, :nickname, :face, :id
    alias screen_name nickname
    alias name realname
  end
end