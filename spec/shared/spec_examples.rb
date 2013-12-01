shared_examples_for 'an abstract component' do
  let(:name) { 'some_component' }
  let(:opts) {{ register: false }}
  let(:blk)  {proc{ 1 + 1 }}

  let(:object) do
    subject.class.new(name, opts, &blk)
  end

  it 'should have a name' do
    object.identifier.should be_a(String) # eql 'something'
  end

  it 'should have options' do
    object.component_options.should be_a(Hash) # eql({ opt_key: 'opt_val' })
  end
  
  it 'should have a block' do
    object.closure.should_not be_nil
  end
end
