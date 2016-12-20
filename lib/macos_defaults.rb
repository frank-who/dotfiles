module MacosDefaults

  def file_basename(file)
    File.basename(file).gsub(/^dot_/, '.')
  end

  def message(text, indent: 0, returns: 1)
    puts [' ' * indent, text, "\n" * returns].join
  end

end
