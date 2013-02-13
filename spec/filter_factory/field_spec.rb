require "spec_helper"

describe FilterFactory::Field do
  describe "#initialize" do
    it "should create field with name & condition specified" do
      field = described_class.new(:name, :eq)
      field.should be_instance_of(described_class)
      field.alias.should == :name
      field.name.should == :name
      field.condition.should == :eq
    end

    it "should create field with name, condition & options specified" do
      field = described_class.new(:name, :eq, alias: :my_name)
      field.should be_instance_of(described_class)
      field.alias.should == :my_name
      field.name.should == :name
      field.condition.should == :eq
    end

    it "should raise error if name is not specified" do
      expect{ described_class.new }.to raise_error(ArgumentError)
    end

    it "should raise error if condition is not specified" do
      expect{ described_class.new(:name) }.to raise_error(ArgumentError)
    end

    it "should raise error if wrong condition specified" do
      expect{ described_class.new(:name, :my_eq) }.to raise_error(ArgumentError)
    end
  end

  describe "#==" do
    it "should be equal to obj if it is an instance of Field & it has equal name, condition & alias" do
      f1 = described_class.new(:name, :eq)
      f2 = described_class.new(:name, :eq, alias: :name)
      f1.should == f2
    end

    it "should not be equal to obj if it is not an instance of Field" do
      f = described_class.new(:name, :eq)
      f.should_not == []
      f.should_not == {}
      f.should_not == 0
    end

    it "should not be equal to obj if it is an instance of Field & it does not have equal name" do
      described_class.new(:name, :eq).should_not == described_class.new(:my_name, :eq)
    end

    it "should not be equal to obj if it is an instance of Field & it does not have equal condition" do
      described_class.new(:name, :eq).should_not == described_class.new(:name, :ne)
    end

    it "should not be equal to obj if it is an instance of Field & it does not have equal alias" do
      described_class.new(:name, :eq).should_not == described_class.new(:name, :eq, alias: :my_name)
    end
  end
end