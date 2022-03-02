class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def initialize()
    #    @board = ["X", "X", "X", "X", "X", "X", "X", "X", "X"]
       @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        
        # " X | X | X "
        # system("clear")

        @board.each_with_index do |cell, index|
            if index% 3 === 0
                print " " + cell
            elsif index%3 === 1
                print " | " + cell + " | "
            elsif index%3 === 2
                print cell + " \n"
                
                # if (index < @board.length - 1)
                #     puts "-----------"
                # end
                
                puts "-----------" if (index < @board.length-1)
            end
        end
    end

    def input_to_index(user_input)
        ui = user_input.to_i
        ui -= 1

        return ui
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(index)
        # If at a given index the cell is not " " the return true
        # If it is " " then return false
        @board[index] != " "
    end

    def valid_move?(index)
        # check if the position is not taken
        # check if the position is between 0-8
        !position_taken?(index) && index >= 0 && index <= 8
    end 

    def turn_count
        count = 0
        @board.each_with_index do |cell, index|
            position_taken?(index) && count+=1
        end

        return count
    end

    def current_player
        turn_count%2 == 0 ? "X" : "O"
    end

    def turn
        puts "Make your move (1-9)"
        user_input = gets
        index = input_to_index(user_input)
        if(valid_move?(index))
            move(index, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        result = nil
        WIN_COMBINATIONS.each do |combo|
           won = (@board[combo[0]] != " ") && 
           (@board[combo[0]] == @board[combo[1]]) && 
           (@board[combo[1]] == @board[combo[2]]) 
            if won
                result = combo
                break
            end
        end

        result
    end

    def full?
        turn_count >=9 && !won?

    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        if(won?)
           return current_player === "X" ? "O" : "X"
        end
    end

    # until the game is over
    #     take turns
    # end

    # if the game was won
    #     congratulate the winner
    # else if the game was a draw
    #     tell the players it ended in a draw
    # end

    def play
        until over?
            self.turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end

    end

end
