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

    def ask_question(place)
    	puts case current_category(place)
    	when 'Pop'
    		@pop_questions.shift
    	when 'Science'
    		@science_questions.shift
    	when 'Sports'
    		@sports_questions.shift
    	when 'Rock'
    		@rock_questions.shift
    	end
    end

    def current_category(place)
      case place
      when 0, 4, 8
         'Pop'
      when 1, 5, 9
         'Science'
      when 2, 6, 10
         'Sports'
      when 3, 7, 11
         'Rock'
      end
    end



	end
end