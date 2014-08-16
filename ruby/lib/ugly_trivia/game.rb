require 'ugly_trivia/questions'
module UglyTrivia
  class Game
    def  initialize
      @players = []
      @places = Array.new(6, 0)
      @purses = Array.new(6, 0)
      @in_penalty_box = Array.new(6, nil)

      @current_player = 0
      @is_getting_out_of_penalty_box = false

      @questions = UglyTrivia::Questions.new
    end


    def is_playable?
      how_many_players >= 2
    end

    def add(player_name)
      @players.push player_name
      @places[how_many_players] = 0
      @purses[how_many_players] = 0
      @in_penalty_box[how_many_players] = false

      puts "#{player_name} was added"
      puts "They are player number #{@players.length}"

      true
    end

    def how_many_players
      @players.length
    end

    def roll(roll)
      puts "#{@players[@current_player]} is the current player"
      puts "They have rolled a #{roll}"

      if @in_penalty_box[@current_player]
        if roll % 2 != 0
          @is_getting_out_of_penalty_box = true

          puts "#{@players[@current_player]} is getting out of the penalty box"
          @places[@current_player] = @places[@current_player] + roll
          @places[@current_player] = @places[@current_player] - 12 if @places[@current_player] > 11

          puts "#{@players[@current_player]}'s new location is #{@places[@current_player]}"
          puts "The category is #{@questions.current_category(@places[@current_player])}"
          @questions.ask_question(@places[@current_player])
        else
          puts "#{@players[@current_player]} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false
          end

      else

        @places[@current_player] = @places[@current_player] + roll
        @places[@current_player] = @places[@current_player] - 12 if @places[@current_player] > 11

        puts "#{@players[@current_player]}'s new location is #{@places[@current_player]}"
        puts "The category is #{@questions.current_category(@places[@current_player])}"
        @questions.ask_question(@places[@current_player])
      end
    end

  private

  public

  def in_penalty_box
    @in_penalty_box[@current_player]
  end
  attr_reader :is_getting_out_of_penalty_box

    def was_correctly_answered
      if in_penalty_box
        if is_getting_out_of_penalty_box
          puts 'Answer was correct!!!!'
          @purses[@current_player] += 1
          puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."

          winner = winner?
        else
          winner = false
        end
      else
        puts "Answer was corrent!!!!"
        @purses[@current_player] += 1
        puts "#{@players[@current_player]} now has #{@purses[@current_player]} Gold Coins."

        winner = winner?
      end
        move_to_next_player
        winner
    end

    def wrong_answer
  		puts 'Question was incorrectly answered'
  		puts "#{@players[@current_player]} was sent to the penalty box"
  		@in_penalty_box[@current_player] = true

      move_to_next_player
  		return true
    end

    def move_to_next_player
      @current_player += 1
      @current_player = 0 if @current_player == @players.length
    end

  private

    def winner?
      @purses[@current_player] == 6
    end
  end
end
