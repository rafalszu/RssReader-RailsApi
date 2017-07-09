describe 'serializers' do
  Rails.application.eager_load!

  ApplicationRecord.descendants.each do |model|
    it "serializer for #{model.name} derive from BaseSerializer" do
      serializer_class = "#{model.name}Serializer".constantize

      expect(serializer_class).to be < BaseSerializer
    end
  end
end
