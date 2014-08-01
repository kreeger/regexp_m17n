# encoding: utf-8
require 'minitest/autorun'
require_relative '../lib/regexp_m17n'

require 'iconv'

class RegexpTest < MiniTest::Unit::TestCase
  def test_non_empty_string
    Encoding.list.each do |enc|
      begin
        encoded = '.'.encode(enc)
      rescue Encoding::ConverterNotFoundError
        encoded = Iconv.conv('.'.encoding.to_s, enc.to_s, '.')
      end
      assert(RegexpM17N.non_empty?(encoded))
    end
  end
end
