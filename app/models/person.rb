class Person < ActiveRecord::Base
  default_scope -> { order(:sort_name) }
  validates :key_name, presence: true

  # Get the concatenated full name of the person
  def full_name
    ordered_names = [pre_titles, pre_names, key_name_prefix,
                     key_name,
                     post_names, key_name_suffix, qualifications, post_titles]
    ordered_names.reject(&:blank?).join(' ')
  end

  # Get the sorting key of the person
  def sort_name
    ordered_names = [key_name, pre_titles, pre_names, key_name_prefix,
                     post_names, key_name_suffix, qualifications, post_titles]
    ordered_names.reject(&:blank?).join(', ')
  end
end
