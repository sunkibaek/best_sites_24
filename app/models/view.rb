class View < ActiveRecord::Base
  belongs_to :site, counter_cache: true, dependent: :destroy
end
