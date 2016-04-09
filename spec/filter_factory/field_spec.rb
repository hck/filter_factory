require 'spec_helper'

RSpec.describe FilterFactory::Field do
  describe '#initialize' do
    it 'creates field with name & condition specified' do
      field = described_class.new(:name, :eq)
      expect([field.alias, field.name, field.condition]).to eq([:name, :name, :eq])
    end

    it 'creates field with name, condition & options specified' do
      field = described_class.new(:name, :eq, alias: :my_name)
      expect([field.alias, field.name, field.condition]).to eq([:my_name, :name, :eq])
    end

    it 'raises error if name is not specified' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it 'raises error if condition is not specified' do
      expect { described_class.new(:name) }.to raise_error(ArgumentError)
    end

    it 'raises error if wrong condition specified' do
      expect { described_class.new(:name, :my_eq) }.to raise_error(ArgumentError)
    end
  end

  describe '#==' do
    it 'equals to obj if it is an instance of Field & it has equal name, condition & alias' do
      f1 = described_class.new(:name, :eq)
      f2 = described_class.new(:name, :eq, alias: :name)
      expect(f1 == f2).to eq(true)
    end

    it 'is not equal to obj if it is not an instance of Field' do
      f = described_class.new(:name, :eq)
      expect([f == [], f == {}, f == 0]).to eq([false, false, false])
    end

    it 'is not equal to obj if it is an instance of Field & it does not have equal name' do
      f1 = described_class.new(:name, :eq)
      f2 = described_class.new(:my_name, :eq)
      expect(f1 == f2).to eq(false)
    end

    it 'is not equal to obj if it is an instance of Field & it does not have equal condition' do
      f1 = described_class.new(:name, :eq)
      f2 = described_class.new(:name, :ne)
      expect(f1 == f2).to eq(false)
    end

    it 'is not equal to obj if it is an instance of Field & it does not have equal alias' do
      f1 = described_class.new(:name, :eq)
      f2 = described_class.new(:name, :eq, alias: :my_name)
      expect(f1 == f2).to eq(false)
    end
  end
end
