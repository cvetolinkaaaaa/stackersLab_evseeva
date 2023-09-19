class Raspberry
    @@states = ["Отсутствует", "Цветение", "Зеленая", "Красная"]

    def initialize(index)
        @index = index
        @state = @@states.first
    end

    def ripe?
        @state == @@states.last
    end

    def grow! 
        @state == @@states[@@states.index(@state) + 1] unless ripe?
    end
end

class RaspberryBush
    
    def initialize(number_of_raspberries)
        @raspberries = Array.new(number_of_raspberries) {Raspberry.new 0}
    end

    def grow_all!
        @raspberries.each(&:grow!)
    end

    def ripe_all?
        @raspberries.all?(&:ripe?)
    end

    def give_away_all!
        @raspberries = []
    end
end

class Human
    attr_reader :name

    def initialize(name, plant)
        @name = name
        @plant = plant
    end

    def work!
        @plant.grow_all!
    end

    def harvest
        if @plant.ripe_all?
            @plant.give_away_all!
        else
            puts "Ягоды не созрели, надо работать еще"
        end
    end

    def self.knowledge_base
        puts "Сажайте малину в солнечном, но защищенном от ветра месте"
    end
end

class RaspberryBushGame
    
    def initialize(number_of_raspberries)
        @raspberries = Array.new(number_of_raspberries) {Raspberry.new rand(0)}
    end

    def grow_all!
        @raspberries.each(&:grow!)
    end

    def ripe_all?
        @raspberries.all?(&:ripe?)
    end

    def give_away_all!
        @raspberries = []
    end

    def how_many_raspberries_ripe
        count = 0
        @raspberries.each do |raspberry|
            if raspberry.ripe?
                count += 1
            end
        end
        return count
    end

end

class HumanGame
    attr_reader :name

    def initialize(name, plant)
        @name = name
        @plant = plant
    end

    def work!
        @plant.grow_all!
    end

    def harvest
        if @plant.ripe_all?
            @plant.give_away_all!
            puts "Победа! Созрели все ягоды"
        else
            puts "Созрело только #{@plant.how_many_raspberries_ripe}, вы проиграли"
        end
    end

    def self.knowledge_base
        puts "Сажайте малину в солнечном, но защищенном от ветра месте"
    end
end

#if __FILE__ == $PROGRAM_NAME
#    Human.knowledge_base
#    plant = RaspberryBush.new(10)
#    human = Human.new("Галина", plant)
#    human.work!
#    human.harvest
#    while !plant.ripe_all?
#        human.work!
#    end
#    human.harvest
#end



puts "Введите ваше имя"
name = gets.chomp
plant = RaspberryBushGame.new(10)
human = HumanGame.new(name, plant)
puts "Привет, #{name}, давай сыграем в игру. У тебя есть куст с ягодами. Ты можешь выращивать их и собирать. Ты выигрываешь, если соберешь все ягоды созревшими.
Нажми 1, чтобы выращивать ягоды. Нажми 2, чтобы собрать их."
command = gets.chomp
while command == 1
    human.work!
    puts "Ягоды выращены"
    command = gets.chomp
end
human.harvest
