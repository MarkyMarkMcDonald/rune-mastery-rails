class Contrast

  def initialize(pro_name, rune_choices)
    @pro_name = pro_name
    @rune_choices = rune_choices
  end
  attr_reader :pro_name

  def quints
    @rune_choices.select do |contrast|
      contrast[:rune].type == 'black'
    end.sort_by do |contrast|
      contrast[:difference]
    end.reverse
  end

  def marks
    @rune_choices.select do |contrast|
      contrast[:rune].type == 'red'
    end.sort_by do |contrast|
      contrast[:difference]
    end.reverse
  end

  def seals
    @rune_choices.select do |contrast|
      contrast[:rune].type == 'blue'
    end.sort_by do |contrast|
      contrast[:difference]
    end.reverse
  end

  def glyphs
    @rune_choices.select do |contrast|
      contrast[:rune].type == 'yellow'
    end.sort_by do |contrast|
      contrast[:difference]
    end.reverse
  end
end
