#!/usr/bin/ruby
#

t = `aconnect -i -l`
ports = []
linnPort = -1
t.lines.each do |l|
  /client (\d*)\: '(.*)'/=~l
  port = $1
  name = $2
  # we skip empty lines and the "Through" port
  unless $1.nil? || $1 == '0' || /Through/=~l
    ports << port
    if name.index("LinnStrument") == 0
      linnPort = port
    end
  end
end

ports.each do |p1|
  ports.each do |p2|
    # probably not a good idea to connect a port to itself
    # also skip sending to LinnStrument
    unless p1 == p2 || p2 == String(linnPort)
      system  "aconnect #{p1}:0 #{p2}:0"
    end
  end
end

