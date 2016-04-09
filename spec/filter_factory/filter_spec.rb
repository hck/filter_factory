require 'spec_helper'

RSpec.describe FilterFactory::Filter do
  describe '::create' do
    it 'creates filter and execute block' do
      test_fields = [[:field1, :eq], [:field2, :eq], [:field3, :eq]]

      filter = described_class.create do
        test_fields.each do |arr|
          field *arr
        end
      end

      expect(filter.fields.map {|f| [f.name, f.condition]}).to eq(test_fields)
    end

    it 'defines singleton method for defined field by its name if no alias option specified' do
      filter = described_class.create do
        field :name, :eq
      end

      expect(filter).to respond_to(:name, :'name=')
    end

    it 'defines singleton method for defined field by its alias if alias option specified' do
      filter = described_class.create do
        field :name, :eq, alias: :my_name
      end

      expect(filter).to respond_to(:my_name, :'my_name=')
    end

    it 'raises error if duplicate field definition found' do
      expect {
        described_class.create do
          field :name, :eq
          field :surname, :regex, alias: :last_name
          field :name, :eq, alias: :name
        end
      }.to raise_error(FilterFactory::Filter::DuplicateFieldError)
    end
  end

  describe '#<field_name>, #<field_name>=' do
    it 'gets field value' do
      filter = described_class.create do
        field :name, :eq
      end

      filter.fields.first.value = 'sample name'
      expect(filter.name).to eq('sample name')
    end

    it 'sets field value' do
      filter = described_class.create do
        field :name, :eq
      end

      filter.name = 'sample name'
      expect(filter.fields.first.value).to eq('sample name')
    end
  end

  describe '#attributes, #attributes=' do
    it 'respond_tos attributes & attributes= methods' do
      filter = described_class.create do
        field :name, :eq
      end

      expect(filter).to respond_to(:attributes, :attributes=)
    end

    it 'returns valid attributes' do
      filter = described_class.create do
        field :name, :eq
        field :surname, :regex, alias: :last_name
      end
      filter.name = 'test name'

      expected_attributes = HashWithIndifferentAccess.new(name: 'test name', last_name: nil)

      expect(filter.attributes).to eq(expected_attributes)
    end

    it 'fills filter values from hash' do
      filter = described_class.create do
        field :name, :eq
        field :surname, :regex, alias: :last_name
      end

      attributes = { name: 'my test name', last_name: 'surname here' }
      filter.attributes = attributes
      expect(filter.attributes).to eq(HashWithIndifferentAccess.new(attributes))
    end
  end

  describe '#get_field' do
    it 'responds to #get_field method' do
      expect(subject).to respond_to(:get_field)
    end

    it 'returns valid field by calling #get_field' do
      filter = described_class.create do
        field :name, :eq
        field :surname, :regex, alias: :last_name
      end

      field_name = filter.get_field(:name)
      expect([field_name.class, field_name.condition]).to eq([FilterFactory::Field, :eq])

      field_surname = filter.get_field(:surname)
      expect([field_surname.class, field_surname.condition]).to eq([FilterFactory::Field, :regex])

      expect(filter.get_field(:my_name)).to be_nil
    end
  end

  described_class::CONDITIONS.each do |condition|
    it 'responds to #{condition} method' do
      expect(subject).to respond_to(condition)
    end

    it "defines field with '#{condition}' condition" do
      filter = described_class.create{ public_send(condition, :name) }
      expect(filter.get_field(:name).condition).to eq(condition)
    end
  end
end
