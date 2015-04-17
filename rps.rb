#write out description
#Extract Verbs and Nouns
#Verbs will be methods
#Nouns will be Classes

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
      puts "It's a Tie!"
    elsif (player.choice == 'p' && computer.choice == 'r') ||
          (player.choice == 'r' && computer.choice == 's') ||
          (player.choice == 's' && computer.choice == 'p')
          puts "============================================="
          winning_message(player.choice)
          puts "#{player.name} wins!"
          puts "============================================="
    else
      puts "============================================="
      winning_message(computer.choice)
      puts "#{computer.name} wins!"
      puts "============================================="
    end
  end

  def winning_message(winning_choice)
    case winning_choice
    when 'p'
      puts "Paper smothers Rock!"
    when 'r'
      puts "Rock smashes Scissors!"
    when 's'
      puts "Scissors dice Paper!"
    end
  end

  def play_again
    puts "Would you like to play again? (y/n)"
    response = gets.chomp.downcase

    if response == 'y'
      Game.new.play
    elsif response == 'n'
      puts "Goodbye"
      exit
    end
  end

  def play
    greeting_message
    player.pick_hand
    computer.pick_hand
    compare_choices
    play_again
  end
end

Game.new.play




