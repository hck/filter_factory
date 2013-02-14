require "spec_helper"

describe FilterFactory::Filter do
  describe "::create" do
    it "should create filter and execute block" do
      test_fields = [[:field1, :eq], [:field2, :eq], [:field3, :eq]]

      filter = described_class.create do
        test_fields.each do |arr|
          field *arr
        end
      end

      filter.should be_a(described_class)

      filter.fields.map{|f| [f.name, f.condition]}.should == test_fields
    end

    it "should define singleton method for defined field by its name if no alias option specified" do
      filter = described_class.create do
        field :name, :eq
      end

      filter.should respond_to(:name, :'name=')
    end

    it "should define singleton method for defined field by its alias if alias option specified" do
      filter = described_class.create do
        field :name, :eq, alias: :my_name
      end

      filter.should respond_to(:my_name, :'my_name=')
    end

    it "should raise error if duplicate field definition found" do
      expect do
        described_class.create do
          field :name, :eq
          field :surname, :regex, alias: :last_name
          field :name, :eq, alias: :name
        end
      end.to raise_error(FilterFactory::Filter::DuplicateFieldError)
    end
  end

  describe "#<field_name>, #<field_name>=" do
    it "should get field value" do
      filter = described_class.create do
        field :name, :eq
      end

      filter.fields.first.value = "sample name"
      filter.name.should == "sample name"
    end

    it "should set field value" do
      filter = described_class.create do
        field :name, :eq
      end

      filter.name = "sample name"
      filter.fields.first.value.should == "sample name"
    end
  end

  describe "#attributes, #attributes=" do
    it "should respond_to attributes & attributes= methods" do
      filter = described_class.create do
        field :name, :eq
      end

      filter.should respond_to(:attributes, :attributes=)
    end

    it "should return valid attributes" do
      filter = described_class.create do
        field :name, :eq
        field :surname, :regex, alias: :last_name
      end
      filter.name = "test name"

      filter.attributes.should == HashWithIndifferentAccess.new({name: "test name", last_name: nil})
    end

    it "should fill filter values from hash" do
      filter = described_class.create do
        field :name, :eq
        field :surname, :regex, alias: :last_name
      end

      attributes = {name: "my test name", last_name: "surname here"}
      filter.attributes = attributes
      filter.attributes.should == HashWithIndifferentAccess.new(attributes)
    end
  end

  describe "#get_field" do
    it "should respond to #get_field method" do
      should respond_to(:get_field)
    end

    it "should return valid field by calling #get_field" do
      filter = described_class.create do
        field :name, :eq
        field :surname, :regex, alias: :last_name
      end
      filter.get_field(:name).should be_instance_of(FilterFactory::Field)
      filter.get_field(:name).condition.should == :eq
      filter.get_field(:surname).should be_instance_of(FilterFactory::Field)
      filter.get_field(:surname).condition.should == :regex
      filter.get_field(:my_name).should be_nil
    end
  end

  described_class::CONDITIONS.each do |condition|
    it "should respond to #{condition} method" do
      should respond_to(condition)
    end

    it "should define field with '#{condition}' condition" do
      filter = described_class.create{ public_send(condition, :name) }
      filter.get_field(:name).condition.should == condition
    end
  end
end