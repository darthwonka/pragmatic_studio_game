# frozen_string_literal: true

require_relative 'game_turn'
require_relative 'player'
require_relative 'player_berserk'
require_relative 'player_clumsy'

module StudioGame
  class Game
    attr_reader :title, :players, :treasures

    def initialize(gametitle)
      @title = gametitle.capitalize
      @players = []
      @die = Die.new(6)
    end

    def add_player(newplayer)
      @players << newplayer
    end

    def play(rounds = 10)
      puts "There are #{@players.size} players in #{@title}"
      puts ''.center(50, '-')
      TreasureTrove.list
      puts ''.center(50, '-')
      puts "Getting ready to play #{rounds} rounds"
      sleep(1)

      1.upto(rounds) do |round|
        puts "Round #{round}".center(50, '-')
        @players.each do |player|
          GameTurn.take_turn(player)
          player.get_treasure if player.found_treasure?
        end
      end
    end

    #     ##################################################
    #     # Game Results methods
    #     ##################################################

    def standings
      strong_players, wimpy_players = @players.partition(&:strong?)
      strong_players.sort { |a, b| b.score <=> a.score }
      wimpy_players.sort { |a, b| b.score <=> a.score  }

      puts 'Strong Players'.center(50, '*')
      strong_players.each do |strong|
        print "#{strong.name.ljust(30, '.')}(#{strong.health}) \n"
      end
      puts 'Wimpy Players'.center(50, '*')
      wimpy_players.each do |wimpy|
        print "#{wimpy.name.ljust(30, '.')}(#{wimpy.health}) \n"
      end

      show_treasures
    end

    def show_treasures
      puts 'The Loot!'.center(60, ' ')
      @players.each do |player|
        puts "#{player.name} Treasures!".ljust(50, ' ')
        player.each_found_treasure do |treasure|
          puts treasure.name.to_s.ljust(25, '.') + treasure.points.to_s
        end
        puts 'Total Points'.ljust(25, '.') + player.points.to_s
      end
    end

    def highscores
      filename = File.join(File.dirname(__FILE__), 'highscores.txt')
      if File.exist?(filename)
        lastrun = File.stat(filename).mtime
        puts "#{@title} High Scores from #{lastrun}".center(50, '*')
        File.readlines(filename).each do |line|
          puts line.to_s
        end
      else
        puts "No Highscores yet!\n"
      end
    end

    def save_highscores
      default_score_file = File.join(File.dirname(__FILE__), 'highscores.txt')
      File.delete(default_score_file) if File.exist?(default_score_file)

      sorted_players = @players.sort { |a, b| b.score <=> a.score }
      File.open(default_score_file, 'w') do |file|
        file.puts "\n#{"#{@title} High Scores".center(50, '-')}\n"
        sorted_players.each do |player|
          file.puts "#{player.name.ljust(40, '.')}#{player.score} \n"
        end
      end
    end

    def stats(player)
      puts "I'm #{player.name} with a health of #{player.health} and a score of #{player.score}\n"
    end

    def to_s=
      puts "The #{name} game has #{players.size} in it"
      players.each do |player|
        puts player
      end
    end

    #     ####################################################################################################
    #     FILE UTILITIES
    #     ####################################################################################################
    def load_players(player_file)
      File.readlines(player_file).each do |line|
        newplayer = if line.include?('berserk')
                      BerserkPlayer.from_csv(line)
                    elsif line.include?('clumsy')
                      ClumsyPlayer.from_csv(line)
                    else
                      Player.from_csv(line)
                    end
      rescue ArgumentError
        puts "Found invalid data for player [#{line}]\nPlayer will be ignored."
      else
        add_player(newplayer)
      end
    end
  end

  if __FILE__ == $PROGRAM_NAME
    player1 = Player.new('moe')
    player2 = Player.new('larry', 125)
    player3 = Player.new('curly', 180)
    player4 = Player.new('sHeMp', 35)
    players = [player1, player2, player3, player4]
    knuckleheads = Game.new('knuckleheads')
    players.each do |player|
      knuckleheads.add_player(player)
    end
    knuckleheads.play
    puts knuckleheads.title

  end
end
