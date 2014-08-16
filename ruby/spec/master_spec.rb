require 'spec_helper'

describe 'golden master' do
  def run_game(random_number)
    not_a_winner = false

    game = UglyTrivia::Game.new

    game.add 'Chet'
    game.add 'Pat'
    game.add 'Sue'

    r = Random.new(random_number)

    begin
      game.roll(r.rand(5) + 1)

      if r.rand(9) == 7
        not_a_winner = game.wrong_answer
      else
        not_a_winner = game.was_correctly_answered
      end

    end while not_a_winner
  end

  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end

  before(:each) do
  end
  let(:master_output) {File.read(File.join(File.dirname(__FILE__), 'fixtures', 'master.txt'))}
  it 'should print what the original app printed' do
    output = capture_stdout do
      (0..100).each do  |i|
        run_game(i)
      end
    end
    expect(output).to eql(master_output)
  end
end
