# Generate indents
def indent_emit(depth)
  "  " * depth
end

# Recursively parse the data structure.  Array and hash
# values are emitted verbatim, hash keys are output as
# symobls.
# Note: arrays only support scalars
def recurse_emit(data, depth = 0)
  output = ''
  case data
  when Array
    data.each do |x|
      output << indent_emit(depth) + "- #{x}\n"
    end
  when Hash
    data.each do |x, y|
      output << indent_emit(depth) + ":#{x}:"
      if y.respond_to? :each
        output << "\n#{recurse_emit(y, depth + 1)}"
      else
        output << " #{y}\n"
      end
    end
  end
  output
end

# Generates puppet compatible hiera.conf content
module Puppet::Parser::Functions
  newfunction(:generate_hiera, :type => :rvalue) do |args|
    "---\n" + recurse_emit(args[0])
  end
end
