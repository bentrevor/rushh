# rushh_dir = "#{ENV['HOME']}/code/ruby/rushh"
# rushh_ruby_defs = "#{rushh_dir}/in.rb"
# rushh_sh_defs = "#{rushh_dir}/out.sh"
# lines = File.read(rushh_ruby_defs).split("\n")

# function_names = lines.select do |line|
#   line.lstrip.start_with?('def ')
# end.map do |func|
#   func.gsub('def ', '')
# end

# funcs_with_args, funcs_without_args = function_names.partition { |name| name.include?('(') }

# sh_funcs_without_args = funcs_without_args.map do |func|
#   <<FUNC

# function #{func}() {
#     ruby -e 'load "#{rushh_ruby_defs}"; #{func}'
# }
# FUNC
# end

# sh_funcs_with_args = funcs_with_args.map do |func_with_args|
#   func = func_with_args.gsub(/\(.*\)/, '')

#   <<FUNC

# function #{func}() {
#     cmd=$(echo 'load "#{rushh_ruby_defs}"; #{func}("' $@ '")')
#     ruby -e $cmd
# }
# FUNC
# end

# src = sh_funcs_with_args + sh_funcs_without_args

# sh_defs = "#!/bin/sh\n\n# This is a generated file - you probably don't need to edit this by hand\n#{src.join}"

# File.write(rushh_sh_defs, sh_defs)

class MustDefineMultilineMethods < StandardError; end

def ruby_to_sh(ruby_def)
  sh_funcs_without_args = funcs_without_args.map do |func|
    x=<<FUNC

  function #{func}() {
      ruby -e 'load "#{rushh_ruby_defs}"; #{func}'
  }
FUNC
  end


  ruby_def
end

def get_functions(ruby_defs)
  lines_with_methods = ruby_defs.split("\n").select do |line|
    line.start_with?('def ')
  end

  raise MustDefineMultilineMethods if lines_with_methods.any? do |line|
    line.include?(';')
  end

  lines_with_methods.map do |line|
    line.gsub('def ', '')
  end
end
