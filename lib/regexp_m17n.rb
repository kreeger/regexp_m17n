module RegexpM17N
  def self.non_empty?(str)
    str.unpack('C*').pack('U*') =~ /^.+$/
  end
end
