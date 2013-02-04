# Filtr

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'filtr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filtr

## Usage

Describe your filter:

    @filter = Filtr::Filter.create do
      # filter field definition: field name for ActiveRecord/Mongoid model, filter type
      field :title, :regex
      field :author, :eq
      field :views, :gte
      # ...
    end

Render form as you want in your view:

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
