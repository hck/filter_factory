require 'filter_factory/version'

require 'filter_factory/condition'
require 'filter_factory/field'
require 'filter_factory/filter'

require 'filter_factory/active_record/condition'
require 'filter_factory/active_record/filter'

require 'filter_factory/mongoid/condition'
require 'filter_factory/mongoid/filter'

# FilterFactory module
module FilterFactory
  def self.create(&block)
    FilterFactory::Filter.create(&block)
  end
end
