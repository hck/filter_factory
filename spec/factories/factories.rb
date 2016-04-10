FactoryGirl.define do
  factory :mongoid_post, class: MPost do
    sequence(:title) {|n| "post_#{n}"}
    sequence(:author) {|n| "author_#{n}"}
    sequence(:views) {|n| n}
  end

  factory :active_record_post, class: ARPost do
    sequence(:title) {|n| "post_#{n}"}
    sequence(:author) {|n| "author_#{n}"}
    sequence(:views) {|n| n}
  end
end
