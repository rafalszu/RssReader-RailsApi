require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'Associations' do
    it { should have_many(:feeds) }
    it { should have_many(:entries) }
    it { should have_one(:login) }
  end
  
  describe 'Validations' do
    let(:validemail) { 'dummy@addr.com' }
    let(:notvalidemail) { 'totally-not-a-valid-email-address' }
    subject { described_class.new }
    
    it 'is valid with valid attributes' do
      subject.email = validemail
      expect(subject).to be_valid
    end
    
    it 'is NOT valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
    
    it 'is NOT valid for a nonvalid email' do
      subject.email = notvalidemail
      
      expect(subject).to_not be_valid
    end
    
    it 'is valid for a tagged+ email' do
      subject.email = 'valid+addr@dummy.com'
      
      expect(subject).to be_valid
    end
  end
end
