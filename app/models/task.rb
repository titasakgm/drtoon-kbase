class Task < ApplicationRecord
  has_rich_text :content

  # used to query the attached ActionText directly
  has_one :action_text_rich_text,
    class_name: 'ActionText::RichText',
    as: :record
end
