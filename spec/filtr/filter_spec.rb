require "spec_helper"

describe Filtr::Filter do
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

  it "should define singleton method for defined field" do
    filter = described_class.create do
      field :name, :eq
    end

    filter.should respond_to(:name, :'name=')
  end

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

  it "should respond_to attributes & attributes= methods" do
    filter = described_class.create do
      field :name, :eq
    end

    filter.should respond_to(:attributes, :attributes=)
  end

  it "should return valid attributes" do
    filter = described_class.create do
      field :name, :eq
      field :surname, :regex
    end
    filter.name = "test name"

    filter.attributes.should == HashWithIndifferentAccess.new({name: "test name", surname: nil})
  end

  it "should fill filter values from hash" do
    filter = described_class.create do
      field :name, :eq
      field :surname, :regex
    end

    attributes = {name: "my test name", surname: "surname here"}
    filter.attributes = attributes
    filter.attributes.should == HashWithIndifferentAccess.new(attributes)
  end

  #describe "#conditions" do
  #  it "should return result of query method for each of the condition as a Method object" do
  #    filter = described_class.create do
  #      field :name, :eq
  #    end
  #
  #    filter.name = "sample name"
  #    filter.conditions.first.should be_a(Method)
  #  end
  #end
end