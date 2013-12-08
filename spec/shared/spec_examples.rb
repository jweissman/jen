shared_examples_for 'an abstract component' do
  let(:name) { :some_component }
  let(:opts) {Hash.new} # { register: false }}
  let(:blk)  { proc{ |*args| args } }

  let(:object) do
    subject.class.new(name, opts, &blk)
  end

  it 'should have a name/identifier' do
    object.identifier.should eql(name) # be_a(String) # eql 'something'
  end

  it 'should have options' do
    object.options.should eql(opts) # be_a(Hash) # eql({ opt_key: 'opt_val' })
  end
  
  it 'should have a block' do
    object.closure.should be_true # should_not be_nil
  end

  it 'should evaluate the block' do
    object.value.should eql([opts])
  end
end
