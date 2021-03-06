require "fantasydata/version"
require 'fantasydata/client'
require 'fantasydata/configurable'
require 'fantasydata/box_score'
require 'fantasydata/mlb_box_score'
require 'fantasydata/boxscore/kicking_stat'
require 'fantasydata/boxscore/passing_stat'
require 'fantasydata/boxscore/player_defense_stat'
require 'fantasydata/boxscore/punting_stat'
require 'fantasydata/boxscore/return_stat'
require 'fantasydata/boxscore/receiving_stat'
require 'fantasydata/boxscore/rushing_stat'
require 'fantasydata/boxscore/score'
require 'fantasydata/boxscore/scoring_play'
require 'fantasydata/boxscore/team_defense_stat'
require 'fantasydata/mlb_boxscore/player_game_stat'
require 'fantasydata/bye_week'
require 'fantasydata/fantasy_player_adp'
require 'fantasydata/daily_fantasy_player'
require 'fantasydata/daily_fantasy_points'
require 'fantasydata/injury'
require 'fantasydata/news'
require 'fantasydata/player_detail'
require 'fantasydata/player_game_stat'
require 'fantasydata/player_season_stat'
require 'fantasydata/game_stat'
require 'fantasydata/scoring_detail'
require 'fantasydata/schedule'
require 'fantasydata/team_detail'
require 'fantasydata/score'
require 'fantasydata/stadium'
require 'fantasydata/standings'
require 'fantasydata/timeline'
require 'fantasydata/team_game_stat'
require 'fantasydata/team_season_stat'
require 'fantasydata/error'
require 'fantasydata/version'
require 'fantasydata/daily_fantasy_player_stats'


module Fantasydata
  class << self
    include Fantasydata::Configurable

    # Delegate to a Echowrap::Client
    #
    # @return [Echowrap::Client]
    def client
      @client = Fantasydata::Client.new(options) unless defined?(@client) && @client.hash == options.hash
      @client
    end

    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

    private

      def method_missing(method_name, *args, &block)
        return super unless client.respond_to?(method_name)
        client.send(method_name, *args, &block)
      end
  end
end

Fantasydata.setup
