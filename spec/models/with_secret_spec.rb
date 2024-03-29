require 'rails_helper'

RSpec.describe Secrets::Secret, :type => :model do
  subject(:model_with_secrets) { WithSecret }

  describe 'callbacks' do
    describe 'saving' do
      subject { model_with_secrets.new name: 'John' }

      it 'should obscure secrets after saving' do
        expect(subject.name).not_to be_blank
        subject.save!
        expect(subject.name).to be_blank
      end
    end

    describe 'updating' do
      subject { model_with_secrets.create! name: 'John' }

      it 'should obscure secrets after saving' do
        expect(subject).not_to be_new_record
        expect(subject.name).to be_blank
        subject.name = 'Jan'
        subject.save!
        expect(subject.name).to be_blank
      end
    end
  end

  describe '.secret_attributes' do
    subject { model_with_secrets.secret_attributes }

    it 'returns the secret attributes' do
      is_expected.to eq ['secret_name']
    end
  end

  describe '.secrets' do
    subject { model_with_secrets.secrets }

    it 'returns the secrets' do
      is_expected.to eq ['name']
    end
  end

  describe '.obscure_secrets' do
    subject { model_with_secrets.new name: 'John' }

    it 'sets the secret value to blank ' do
      expect(subject.name).to eq 'John'
      subject.obscure_secrets
      expect(subject.name).to be_blank
    end
  end

  describe '.expose_secrets' do
    subject { model_with_secrets.new }

    before do
      subject.send :write_attribute, :secret_name, 'John'
    end

    it 'retrieves the secret value and write it to his original field' do
      subject.expose_secrets
      expect(subject.name).to eq 'John'
    end
  end

  describe 'accessing secrets' do
    subject { model_with_secrets.create! name: 'John' }

    it 'fails when accessing secret directly' do
      expect { subject.secret_name }.to raise_error NoMethodError
    end
  end
end
