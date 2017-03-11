class Hanoi
    def initialize
        @max_height = 0
        setup

        tower_a = (1..@max_height).to_a.reverse

        @towers = {"A" => tower_a, "B" => [], "C" => []}

        game
    end

    def setup
        puts "Welcome to Tower of Hanoi!"
        puts "Select a tower by entering A, B, or C. Type QUIT at any time to exit."
        puts
        puts "How high will your tower be?"
        print "> "

        until @max_height > 0
            begin
                @max_height = gets.chomp.to_i
                if @max_height <= 0
                    raise
                end
            rescue
                puts "Please enter a number greater than 0."
                print "> "
            end
        end
    end

    def game
        render
        player_turn
        if win?
            render
            puts "Congratulations! You won!"
            exit
        else
            game
        end
    end

    def player_turn
        puts "Which tower will you move from?"
        move_from = get_move
        puts "Which tower will you move to?"
        move_to = get_move
        make_move(move_from, move_to)
    end

    def get_move
        print "> "
        player_move = gets.chomp.upcase
        if player_move == "QUIT"
            puts "Aww, better luck next time!"
            exit
        elsif valid_move?(player_move)
            @towers[player_move] 
        else
            puts "That is not a valid move."
            game
        end
    end

    def valid_move?(input)
        @towers.keys.include?(input) ? true : false
    end

    def make_move(move_from, move_to)
        if move_from.empty?
            puts "That is not a valid move."
            game
        elsif move_to.empty? || (move_from.last < move_to.last)
            move_to << move_from.pop
        else
            puts "That is not a valid move."
            game
        end
    end

    def render
        puts        
        @towers.each do |letter, tower|
            if tower.length < @max_height
                (@max_height - tower.length).times {puts}
            end

            tower.reverse.each do |number|
                puts ("I" * number)
            end
            puts "-" * @max_height
            puts letter.center(@max_height)
            puts
        end
    end

    def win?
        @tower_c == (1..@max_height).to_a.reverse ? true : false
    end

end

Hanoi.new