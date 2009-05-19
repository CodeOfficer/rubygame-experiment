class NilClass
  def rep
    nil
  end
end

class Class
  def shortname
    name().gsub(/^.*:/, '')
  end
end