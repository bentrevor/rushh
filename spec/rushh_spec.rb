require 'spec_helper'

describe '#get_functions' do
  it 'returns a list of method names' do
    ruby_defs = <<DEF
def meth1
end

def meth2
end
DEF

    fns = get_functions(ruby_defs)

    expect(fns.length).to eq(2)
    expect(fns).to include('meth1')
    expect(fns).to include('meth2')
  end

  it 'finds methods with arguments' do
    ruby_defs = <<DEF
def meth(arg)
end
DEF

    fns = get_functions(ruby_defs)

    expect(fns).to include('meth(arg)')
  end

  it 'raises an error if the method tries to fit on one line' do
    ruby_defs = "def meth; end"

    expect {
      get_functions(ruby_defs)
    }.to raise_error(MustDefineMultilineMethods)
  end

  it 'only finds methods that start in column 1' do
    ruby_defs = <<DEF
def meth
end

  def indented_meth
  end
DEF

    fns = get_functions(ruby_defs)
    expect(fns).to include('meth')
    expect(fns.join).not_to include('indented_meth')
  end
end

describe '#ruby_to_sh' do
  context 'method without arguments' do
    it 'converts a ruby method to a shell function' do
      ruby_def = <<DEF
def meth
end
DEF

      expect(ruby_to_sh(ruby_def)).to include("function meth() {")
    end
  end
end
