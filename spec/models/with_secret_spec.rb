require 'rails_helper'

RSpec.describe WithSecret, :type => :model do
  describe '.secret_attributes' do
    subject { described_class.new.secret_attributes }

    it 'returns the secret attributes' do
      is_expected.to eq ['secret_name']
    end
  end

  describe '.secrets' do
    subject { described_class.new.secrets }

    it 'returns the secrets' do
      is_expected.to eq ['name']
    end
  end

  describe '.obscure_secrets' do
    subject { described_class.new name: 'John' }

    it 'sets the secret value to blank ' do
      expect(subject.name).to eq 'John'
      subject.obscure_secrets
      expect(subject.name).to be_blank
    end
  end

  describe '.expose_secrets' do
    subject { described_class.new }

    before do
      subject.send :write_attribute, :secret_name, 'John'
    end

    it 'retrieves the secret value and write it to his original field' do
      subject.expose_secrets
      expect(subject.name).to eq 'John'
    end
  end

  it 'responds to unsecretalize' do
    subject.expose_secrets
  end
end
