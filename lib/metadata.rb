class Metadata

  def self.get(file)
    command  = "mplayer -vo null -ao null -frames 0 -identify #{file}"
    metadata = nil

    output = `#{command}`
    metadata = output.grep(/ID_.*/).collect {|name| name[3..name.length].split('=')}
    metadata = metadata.inject({}) {|hash, (key, value)| hash[key.to_sym] = value.chomp; hash}

    return metadata
  end

end
