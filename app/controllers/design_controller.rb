class DesignController< ApplicationController

  Rune = Struct.new(:name, :count)

  def show
    @user_runes = {
      quints: [
        Rune.new('Ability Power', 2),
        Rune.new('Movement Speed', 1)
      ],
      marks: [
        Rune.new('Magic Penetration', 9)
      ],
      glyphs: [
        Rune.new('Health', 5),
        Rune.new('Armor', 4)
      ],
      seals: [
        Rune.new('Magic Resistance', 9)
      ]
    }

    @pro_runes = {
      quints: [
        Rune.new('Ability Power', 2),
        Rune.new('Hybrid Penetration', 1)
      ],
      marks: [
        Rune.new('Hybrid Penetration', 9)
      ],
      glyphs: [
        Rune.new('Health', 5),
        Rune.new('Armor', 4)
      ],
      seals: [
        Rune.new('Magic Resistance', 9)
      ]
    }


    @difference = {
      quints: [
        Rune.new('Movement Speed', -1),
        Rune.new('Hybrid Penetration', 1)
      ],
      marks: [
        Rune.new('Magic Penetration', -9),
        Rune.new('Hybrid Penetration', 9)
      ],
      glyphs: [],
      seals: []
    }
  end
end
