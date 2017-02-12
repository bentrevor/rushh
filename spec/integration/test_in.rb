def test_method_without_args
  puts 'passed method_without_args'
end

def test_method_with_args(args)
  puts "args: #{args.split.join(', ')}"
end
