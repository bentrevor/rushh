class MustDefineMultilineMethods < StandardError; end

def main(in_path=nil)
  if in_path
    rushh_dir = "#{ENV['HOME']}/rushh"
    rushh_ruby_defs = in_path
    rushh_sh_defs = "#{rushh_dir}/spec/integration/out.sh"
  else
    rushh_dir = "#{ENV['HOME']}/rushh"
    rushh_ruby_defs = "#{rushh_dir}/in.rb"
    rushh_sh_defs = "#{rushh_dir}/out.sh"
  end
  src = File.read(rushh_ruby_defs)

  methods = get_functions(src)
  src = methods.map { |m| ruby_to_sh(m, rushh_ruby_defs) }

  sh_defs = "#!/usr/bin/env bash\n\n# This is a generated file - you probably don't need to edit this by hand\n#{src.join}"

  File.write(rushh_sh_defs, sh_defs)
end

def ruby_to_sh(func_name, rushh_ruby_defs)
  if func_name.include?("(")
    func = func_name.split('(').first
    <<FUNC
function #{func}() {
    ruby -e "$(echo 'load "#{rushh_ruby_defs}"; #{func}("' $@ '")')"
}
FUNC
  else
    <<FUNC
function #{func_name}() {
    ruby -e 'load "#{rushh_ruby_defs}"; #{func_name}'
}
FUNC
  end
end

def get_functions(ruby_defs)
  lines_with_methods = ruby_defs.split("\n").select { |line| line.start_with?('def ') }
  raise MustDefineMultilineMethods if lines_with_methods.any? { |line| line.include?(';') }

  lines_with_methods.map { |line| line.gsub('def ', '') }
end
