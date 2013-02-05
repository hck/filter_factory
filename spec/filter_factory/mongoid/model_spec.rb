require "spec_helper"

describe MPost do
  before(:each) do
    @posts = FactoryGirl.create_list(:mongoid_post, 10)
  end

  it "should respond to ::filter method" do
    described_class.should respond_to(:filter)
  end

  it "should execute filter methods chain" do
    sample = @posts.sample

    filter = FilterFactory.create do
      field :title,  :eq
      field :author, :eq
      field :views,  :gte
    end

    filter.title = sample.title
    filter.author = sample.author

    described_class.filter(filter).to_a.should == [sample]
  end

  it "should return records with column' values equal to specified value" do
    sample = @posts.sample

    filter = FilterFactory.create do
      field :id,  :eq
    end
    filter.id = sample.id

    described_class.filter(filter).to_a.should == [sample]
  end

  it "should return records with column' values not equal specified value" do
    sample = @posts.sample

    filter = FilterFactory.create do
      field :id,  :ne
    end
    filter.id = sample.id

    described_class.filter(filter).to_a.sort.should == @posts.reject{|p| p.id == sample.id}
  end

  it "should return records with column' values less than specified value" do
    sample = @posts.sample

    filter = FilterFactory.create do
      field :views,  :lt
    end
    filter.views = sample.views

    described_class.filter(filter).map(&:id).sort.should == @posts.select{|p| p.views < sample.views}.map(&:id).sort
  end

  it "should return records with column' values less than or equal to specified value" do
    sample = @posts.sample

    filter = FilterFactory.create do
      field :views,  :lte
    end
    filter.views = sample.views

    described_class.filter(filter).map(&:id).sort.should == @posts.select{|p| p.views <= sample.views}.map(&:id).sort
  end

  it "should return records with column' values greater than specified value" do
    sample = @posts.sample

    filter = FilterFactory.create do
      field :views,  :gt
    end
    filter.views = sample.views

    described_class.filter(filter).map(&:id).sort.should == @posts.select{|p| p.views > sample.views}.map(&:id).sort
  end

  it "should return records with column' values greater than or equal to specified value" do
    sample = @posts.sample

    filter = FilterFactory.create do
      field :views,  :gte
    end
    filter.views = sample.views

    described_class.filter(filter).map(&:id).sort.should == @posts.select{|p| p.views >= sample.views}.map(&:id).sort
  end

  it "should return records with column' values all equal to specified value" do
    sample = @posts.sample(2)
    sample.each{|r| r.update_attribute(:opts, [1, 2, 3, 4])}

    filter = FilterFactory.create do
      field :opts,  :all
    end
    filter.opts = [1, 2, 3, 4]

    described_class.filter(filter).map(&:id).sort.should == sample.map(&:id).sort
  end

  it "should return records with column' values in specified values" do
    sample = @posts.sample(3)

    filter = FilterFactory.create do
      field :id,  :in
    end
    filter.id = sample.map(&:id)

    described_class.filter(filter).map(&:id).sort.should == sample.map(&:id).sort
  end

  it "should return records with column' values not in specified values" do
    sample = @posts.sample(3)

    filter = FilterFactory.create do
      field :id,  :nin
    end
    filter.id = sample.map(&:id)

    described_class.filter(filter).map(&:id).sort.should == (@posts.map(&:id) - sample.map(&:id)).sort
  end

  it "should return records with column' values which match the specified regexp" do
    sample = @posts.sample(3)
    sample.each_with_index{|r,i| r.update_attribute(:title, "my_title_#{i}")}

    filter = FilterFactory.create do
      field :title,  :regex
    end

    filter.title = '_title_'

    described_class.filter(filter).map(&:id).sort.should == sample.map(&:id).sort
  end

  it "should return records with existing column' values" do
    sample = @posts.sample(3)
    sample.each{|r| r.update_attribute(:not_exists, rand(0..25))}

    filter = FilterFactory.create do
      field :not_exists, :exists
    end

    filter.not_exists = true

    described_class.filter(filter).map(&:id).sort.should == sample.map(&:id).sort
  end
end