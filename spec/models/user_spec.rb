require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:feeds) }
    it { should have_many(:entries) }
  end
  
  describe 'Validations' do
    let(:validemail) { 'dummy@addr.com' }
    let(:notvalidemail) { 'totally-not-a-valid-email-address' }
    secret = 'nottellin'
    subject { described_class.new }
    
    it 'is valid with valid attributes' do
      subject.email = validemail
      subject.password = secret
      
      expect(subject).to be_valid
    end
    
    it 'is NOT valid without an email' do
      subject.email = nil
      subject.password = secret
      expect(subject).to_not be_valid
    end
    
    it 'is NOT valid without a password' do
      subject.email = validemail
      subject.password = nil
      
      expect(subject).to_not be_valid
    end
    
    it 'is NOT valid for a nonvalid email' do
      subject.email = notvalidemail
      subject.password = secret
      
      expect(subject).to_not be_valid
    end
    
    it 'is valid for a tagged+ email' do
      subject.email = 'valid+addr@dummy.com'
      subject.password = secret
      
      expect(subject).to be_valid
    end
  end
  
end
