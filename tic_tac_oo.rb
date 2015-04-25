class Square
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def empty?
    @value == ' '
  end

  def mark(marker)
    @value = marker
  end

  def to_s
    @value
  end
end

class Board
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  attr_reader :squares

  def initialize
    @squares = {}
    (1..9).each {|pos| @squares[pos] = Square.new(' ')}
  end

  def empty_positions
    @squares.select {|_, v| v.empty?}.keys
  end

  def empty_squares
    @squares.select {|_, v| v.empty?}.values
  end

  def is_full?
    empty_positions.size == 0
  end

  def three_squares_in_a_row?(marker)
    WINNING_LINES.each do |line|
      counter = 0
      counter += 1 if squares[line[0]].value == marker
      counter += 1 if squares[line[1]].value == marker
      counter += 1 if squares[line[2]].value == marker
      return true if counter == 3
    end
    false
  end

  def mark_square(position, marker)
   @squares[position].mark(marker)
 end

  def draw
  system 'clear'
  puts
  puts "     |     |"
  puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
  puts "     |     |"
  puts
  end
end

class Player
  attr_reader :marker, :name

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game
  def initialize
    @board = Board.new
    @human = Player.new("T-bone Walker", "X")
    @computer = Player.new("R2D2", "O")
    @current_player = @human
  end

  def current_player_marks_square
    if @current_player == @human
      puts "Please choose an empty position #{@board.empty_positions}"
      choice = gets.chomp.to_i
    else
      choice = @board.empty_positions.sample
    end
    @board.mark_square(choice, @current_player.marker)
  end

  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def current_player_wins?
     @board.three_squares_in_a_row?(@current_player.marker)
  end

  def play
    @board.draw
    loop do
      current_player_marks_square
      @board.draw
        if current_player_wins?
          puts "#{@current_player.name} won!"
          break
        elsif @board.is_full?
          puts "It's a tie!"
          break
        else
        alternate_player
        end
    end
    puts "Goodbye!"
  end
end

  Game.new.play
