# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  message    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Micropost < ApplicationRecord
  validates :message, presence: true
  belongs_to :user
end
