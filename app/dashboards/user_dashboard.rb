require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    posts: Field::HasMany,
    active_relationships: Field::HasMany.with_options(class_name: "Relationship"),
    passive_relationships: Field::HasMany.with_options(class_name: "Relationship"),
    following: Field::HasMany.with_options(class_name: "User"),
    followers: Field::HasMany.with_options(class_name: "User"),
    comments: Field::HasMany,
    active_likes: Field::HasMany.with_options(class_name: "Like"),
    liking: Field::HasMany.with_options(class_name: "Post"),
    id: Field::Number,
    name: Field::String,
    email: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    password_digest: Field::String,
    remember_digest: Field::String,
    admin: Field::Boolean,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    email
    posts
    following
    followers
    comments
    liking
    created_at
    updated_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  posts
  following
  followers
  comments
  liking
  id
  name
  email
  created_at
  updated_at
  ].freeze

  '''
  SHOW_PAGE_ATTRIBUTES = %i[
    posts
    active_relationships
    passive_relationships
    following
    followers
    comments
    active_likes
    liking
    id
    name
    email
    created_at
    updated_at
    password_digest
    remember_digest
    admin
  ].freeze
  '''

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  name
  email
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
