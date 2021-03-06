# frozen_string_literal: true

class Katana < ApplicationRecord
  KATANA_TYPE = {
    1 => '短刀',
    2 => '脇差',
    3 => '打刀',
    4 => '太刀',
    5 => '大太刀',
    6 => '槍',
    7 => '薙刀',
    8 => '剣'
  }.freeze
end
