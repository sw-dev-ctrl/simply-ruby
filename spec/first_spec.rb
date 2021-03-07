RSpec.describe Exporter do
  
  it "has a version number" do
    expect("First::VERSION").not_to be nil
  end
 
  it 'helps in mocking a class' do
    puts (expected_data_structure)
    exp=Exporter::AnExporter.new
    
    allow_any_instance_of(Documentz::AwsUploader).to receive(:s3upload).with( {:docs=>[1,2]} )
    exp.letsUpload
    ## how to check if the array size (:docs)==2
  end
  
  context 'Using RSpec matcher to check the size of array received by Mock method' do 
    RSpec::Matchers.define :expected_data_structure do
      match { |actual| actual.is_a?(Hash)         &&
                       actual[:docs].is_a?(Array) && 
                       actual[:docs].size == 2    &&
                       actual[:docs].all?(Integer) 
      }
    end
    subject(:exporter) { Exporter::AnExporter.new }
    let(:spy) { instance_double('Documentz::AwsUploader') }
    before do 
      allow(Documentz::AwsUploader).to receive(:new).and_return(spy) 
    end
    it 'calls s3upload with the expected arguments' do
      exporter.letsUpload
      expect(spy).to have_received(:s3upload).with(expected_data_structure)
    end
  end

end
