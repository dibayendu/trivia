module UglyTrivia
	class Questions

    def  initialize
      @pop_questions = []
      @science_questions = []
      @sports_questions = []
      @rock_questions = []

      50.times do |i|
        @pop_questions.push "Pop Question #{i}"
        @science_questions.push "Science Question #{i}"
        @sports_questions.push "Sports Question #{i}"
        @rock_questions.push create_rock_question(i)
      end

    end

    def create_rock_question(index)
      "Rock Question #{index}"
    end

    private
    
    def ask_question
      puts @pop_questions.shift if current_category == 'Pop'
      puts @science_questions.shift if current_category == 'Science'
      puts @sports_questions.shift if current_category == 'Sports'
      puts @rock_questions.shift if current_category == 'Rock'
    end

	end
end