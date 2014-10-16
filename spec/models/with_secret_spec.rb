require 'rails_helper'

RSpec.describe WithSecret, :type => :model do
  subject { described_class.new }

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

  it 'responds to secretalize' do
    subject.secretalize
  end

  it 'responds to unsecretalize' do
    subject.unsecretalize
  end
end
