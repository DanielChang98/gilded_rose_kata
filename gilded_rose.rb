SPECIAL_ITEMS = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Sulfuras, Hand of Ragnaros", "Conjured Mana Cake"].freeze #freeze will store in memory for better performance.

def update_quality(items)
  items.each do |item|
    if is_special_item?(item)
      special_item(item)
    else
      item.sell_in > 0 ? decrement_normal_item(item, 1) : decrement_normal_item(item, 2)
    end

    item.sell_in -= 1
  end
end

def is_special_item?(item)
  SPECIAL_ITEMS.include? item.name
end

def decrement_normal_item(item, num)
  if item.quality > 0
    case num
    when 1
      item.quality -= 1
    when 2
      item.quality -= 2
    end
  end
end

def special_item(item)
  if item.name == "Aged Brie"
    change_aged_brie(item)
  elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
    change_backstage_pass(item)
  elsif item.name == "Conjured Mana Cake"
    change_conjured_item(item)
  else
    change_sulfuras(item)
  end
end

def change_aged_brie(item)
  if item.quality < 50
    if item.sell_in <= 0 && item.quality <= 48
      item.quality += 2
    else
      item.quality += 1
    end
  end
end

def change_backstage_pass(item)
  if item.quality < 50
    if item.sell_in <= 0
      item.quality = item.quality - item.quality
    elsif item.sell_in < 6
      item.quality += 3
    elsif item.sell_in < 11
      item.quality += 2
    else
      item.quality += 1
    end
  end
end

def change_sulfuras(item)
  item.sell_in += 1
end

def change_conjured_item(item)
  if item.quality > 0
    if item.sell_in <= 0
      item.quality -= 4
    else
      item.quality -= 2
    end
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

