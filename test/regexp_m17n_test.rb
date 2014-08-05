# encoding: utf-8
require 'minitest/autorun'
require_relative '../lib/regexp_m17n'

class RegexpTest < MiniTest::Unit::TestCase
  def test_non_empty_string
    Encoding.list.each do |enc|
      assert(RegexpM17N.non_empty?(string_for_encoding('.', enc)))
    end
  end

  def test_empty_string
    Encoding.list.each do |enc|
      assert(!RegexpM17N.non_empty?(string_for_encoding('', enc)))
    end
  end

  # Produce a properly-encoded string for testing. If the encoding passed in
  # is a dummy encoding, either force the encoding to provide a validly-encoded
  # string, or in the case of UTF-16 and UTF-32, reduce the string to a sequence
  # of raw unsigned integer values, reassemble it, and then encode it.
  #
  # If either of these methods fail to produce a string with valid encoding,
  # fail. This method does not fail for any encoding listed in Encoding.list.
  #
  # @return [String] The encoded string.
  def string_for_encoding(base_string, encoding)
    if encoding.dummy?
      string = base_string.force_encoding(encoding)
      return string if string.valid_encoding?
      # Happens for UTF-16 and UTF-32; this produces a validly-encoded string
      string = base_string.unpack('C*').pack('U*').encode(encoding)
      return string if string.valid_encoding?
      fail "Could not encode #{base_string} with encoding #{encoding}."
    else
      base_string.encode(encoding)
    end
  end
end