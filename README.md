# FilterFactory

[![Build Status](https://travis-ci.org/hck/filter_factory.png)](https://travis-ci.org/hck/filter_factory) [![Code Climate](https://codeclimate.com/github/hck/filter_factory/badges/gpa.svg)](https://codeclimate.com/github/hck/filter_factory)

FilterFactory allows you to easily fetch ActiveRecord/Mongoid models that match specified filters.

## Installation

Add this line to your application's Gemfile:

    gem 'filter_factory'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filter_factory

## Usage

Describe your filter:

    @filter = FilterFactory.create do
      # filter field definition: field name for ActiveRecord/Mongoid model, filter type
      field :title, :regex
      field :author, :eq
      field :views, :gte

      # add aliases for the same field with different conditions
      field :created_at, :gte, alias: :created_at_gte
      field :created_at, :lte, alias: :created_at_lte

      # ...
    end

Alternate way to create your filter:

    @filter = FilterFactory.create do
        # type filter type as method and field name as an argument
        eq :author
        gte :views
        is_in :entry_type

        # supply options after field name
        gte :created_at, alias: :created_at_gte
        lte :created_at, alias: :created_at_lte
    end

Render form as you want in your view (use aliases instead of field names if specified):

    <%= form_for @filter, as: :filter do |f| %>
    <div>
        <%= f.label :title %>
        <br/>
        <%= f.text_field %>
    </div>
    <div>
        <%= f.label :author %>
        <br/>
        <%= f.select Author.all.map{|r| [r.name, r.id]} %>
    </div>
    <div>
        <%= f.label :views %>
        <br/>
        <%= f.number_field :views %>
    </div>
    <div>
        <%= f.label :created_at_gte %>
        <br/>
        <%= f.date_select :created_at_gte %>
    </div>
    <div>
        <%= f.label :created_at_lte %>
        <br/>
        <%= f.date_select :created_at_lte %>
    </div>
    <div class="actions">
        <%= f.submit "Filter" %>
    </div>
    <% end %>

Filter your models in controller:

    @filter.attributes(params[:filter]) # update filter with values supplied from the form

    @posts = Post.filter(@filter) # fetch records that match specified filters

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
