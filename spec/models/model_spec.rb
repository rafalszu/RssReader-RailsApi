describe 'Deleteable' do
  Rails.application.eager_load!
  ApplicationRecord.descendants.each do |model|
    next if model.name.eql? 'User'
    it "#{model.name} can be deleted" do
      instance = model.new
      expect(instance).to respond_to(:deleted)
    end
    
    it "#{model.name} behaves like deleteable" do
      instance = model.new
      expect(instance).to respond_to(:delete)
      expect(instance).to respond_to(:delete!)
    end
  end
end
  # ActiveRecord::Base.descendants.each do |model|
  #   puts model.name
  #   # next if model.name.eq 'User'
    
  #   # instance = model.new
  #   # expected = instance.respond_to?(:deleted)
  #   # expected.should be_true
  #   true
  # end  
