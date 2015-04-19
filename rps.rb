#Pseudo 
#Rock, Paper, Scissors
#Player chooses Rock, Paper, Scissors
#Computer chooses Rock, Paper, Scissors
#Compare choices
class Player
  attr_accessor :choice
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Human < Player
  def pick_hand
    begin
      puts "Please choose between (p/r/s)!"
      self.choice = gets.chomp
    end until Game::CHOICES.keys.include?(self.choice)
  end
end

class Computer < Player
  def pick_hand
    self.choice = Game::CHOICES.keys.sample
  end
end

class Game
CHOICES = {'r' => "Rock", 'p' => "Paper", 's' => "Scissors"}

attr_reader :player, :computer

  def initialize
    @player = Human.new("Ricky Martin")
    @computer = Computer.new("R2D2") 
  end

  def greeting_message
    puts "Welcome to the epic battle of Paper, \nRock, Scissors between Ricky Martin and R2D2!"
    puts "============================================="
  end

  def compare_choices
    if player.choice == computer.choice
      player && computer
    elsif (player.choice == 'p' && computer.choice == 'r') ||
          (player.choice == 'r' && computer.choice == 's') ||
          (player.choice == 's' && computer.choice == 'p')
      player
    else
      computer
    end
  end

  def winning_message
    if compare_choices == player && computer
      puts "============================================="
      puts "It's a tie! #{player.name} and #{computer.name} are both winners!"
    elsif compare_choices == player
      puts "============================================="
      puts "#{player.name} wins!!"
    elsif compare_choices == computer
      puts "============================================="
      puts "#{computer.name} wins!"
    end
  end

  def play_again
    puts "Would you like to play again? (y/n)"
    response = gets.chomp.downcase
    if response == 'y'
      Game.new.play
    elsif response == 'n'
      puts "Goodbye"
    end
  end

  def play
    greeting_message
    player.pick_hand
    computer.pick_hand
    compare_choices
    #winning_choice
    winning_message
    play_again
  end
end

Game.new.play
