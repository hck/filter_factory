require 'spec_helper'

RSpec.describe ARPost do
  let!(:posts) { posts = FactoryGirl.create_list(:active_record_post, 5) }

  it 'responds to ::filter method' do
    expect(described_class).to respond_to(:filter)
  end

  it 'executes filter methods chain' do
    sample = posts.sample

    filter = FilterFactory.create do
      eq :title
      eq :author, alias: :user
      gte :views
    end

    filter.title = sample.title
    filter.user = sample.author

    expect(described_class.filter(filter).to_a).to eq([sample])
  end

  it 'applies filter to existing relation' do
    rel = described_class.where('views < ?', posts.last.views)

    filter = FilterFactory.create do
      gt :views
    end
    filter.views = 0

    expect(rel.filter(filter).to_a).to eq(posts[0..-2])
  end

  it 'returns records with column values equal to specified value' do
    sample = posts.sample

    filter = FilterFactory.create { eq :id }
    filter.id = sample.id

    expect(described_class.filter(filter).to_a).to eq([sample])
  end

  it 'returns records with column values not equal specified value' do
    sample = posts.sample

    filter = FilterFactory.create { ne :id }
    filter.id = sample.id

    expected_result = posts.reject { |p| p.id == sample.id }
    expect(described_class.filter(filter).to_a.sort).to eq(expected_result)
  end

  it 'returns records with column values less than specified value' do
    sample = posts.sample

    filter = FilterFactory.create { lt :views }
    filter.views = sample.views

    expected_result = posts.select { |p| p.views < sample.views }.map(&:id).sort
    expect(described_class.filter(filter).map(&:id).sort).to eq(expected_result)
  end

  it 'returns records with column values less than or equal to specified value' do
    sample = posts.sample

    filter = FilterFactory.create { lte :views }
    filter.views = sample.views

    expected_result = posts.select { |p| p.views <= sample.views }.map(&:id).sort
    expect(described_class.filter(filter).map(&:id).sort).to eq(expected_result)
  end

  it 'returns records with column values greater than specified value' do
    sample = posts.sample

    filter = FilterFactory.create { gt :views }
    filter.views = sample.views

    expected_result = posts.select { |p| p.views > sample.views }.map(&:id).sort
    expect(described_class.filter(filter).map(&:id).sort).to eq(expected_result)
  end

  it 'returns records with column values greater than or equal to specified value' do
    sample = posts.sample

    filter = FilterFactory.create { gte :views }
    filter.views = sample.views

    expected_result = posts.select { |p| p.views >= sample.views }.map(&:id).sort
    expect(described_class.filter(filter).map(&:id).sort).to eq(expected_result)
  end

  it 'raises NotImplementedError if using \'all\' condition' do
    filter = FilterFactory.create do
      field :opts, :all
    end
    filter.opts = [1, 2, 3, 4]

    expect { described_class.filter(filter) }.to raise_error(NotImplementedError)
  end

  it 'returns records with column values in specified values' do
    sample = posts.sample(3)

    filter = FilterFactory.create do
      field :id, :in
    end
    filter.id = sample.map(&:id)

    expected_result = sample.map(&:id).sort
    expect(described_class.filter(filter).map(&:id).sort).to eq(expected_result)
  end

  it 'returns records with column values not in specified values' do
    sample = posts.sample(3)

    filter = FilterFactory.create { nin :id }
    filter.id = sample.map(&:id)

    expected_result = (posts.map(&:id) - sample.map(&:id)).sort
    expect(described_class.filter(filter).map(&:id).sort).to eq(expected_result)
  end

  it 'returns records with column values which match the specified regexp' do
    sample = posts.sample(3)
    sample.each_with_index { |r, i| r.update_attribute(:title, "my_title_#{i}") }

    filter = FilterFactory.create { regex :title }
    filter.title = '_title_'

    expected_result = sample.map(&:id).sort
    expect(described_class.filter(filter).map(&:id).sort).to eq(expected_result)
  end

  it 'raises NotImplementedError if using \'exists\' condition' do
    filter = FilterFactory.create { exists :not_exists }
    filter.not_exists = true

    expect { described_class.filter(filter) }.to raise_error(NotImplementedError)
  end

  it 'returns records with column values not nil equal to specified value' do
    sample = posts.sample(3)
    sample.each { |r| r.update_attribute(:title, nil) }

    filter = FilterFactory.create { presents :title }
    filter.title = false

    expected_result = sample.map(&:id).sort
    expect(described_class.filter(filter).map(&:id).sort).to eq(expected_result)
  end
end
