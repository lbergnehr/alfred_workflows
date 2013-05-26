# We'll be using Cocoa stuff for transforming unicode characters to their names
require 'osx/cocoa'
include OSX

# Get and check input values
input = "{query}".split " "
if input == nil || input.length == 0
  return
end

MIN_CHAR = 32
MAX_CHAR = 2 ** 16

# Loop over "all" unicode characters
(MIN_CHAR..MAX_CHAR).each do |i|

  # Create a unicode string from this number/byte
  name = OSX::NSMutableString.stringWithFormat "%C", i

  # `name` will be mutated, so saving this in a copy
  char = name.to_str

  if name != nil 
    # Transforming the unicode character to its unicode name
    success = OSX::CFStringTransform name, nil, ")kCFStringTransformToUnicodeName", false

    if success && name != nil && name != ""
      name = name.to_str.downcase
      # If the unicode name matches any word in our query, print it
      if input.any? { |q| name.include? q.downcase }
        puts char
      end

    end
  end
end
