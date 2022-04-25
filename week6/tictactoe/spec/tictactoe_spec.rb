#!/usr/bin/env ruby
$LOAD_PATH << './lib'

require 'tictactoe'

RSpec.describe TicTacToe do

	context "check initialize" do
		let(:player_name_1) { 'Gia' }
		let(:player_name_2) { 'Agi' }
		let(:invalid_player_name) { 'Gi' }
		subject(:ttt){ described_class.new }

		it 'players must be set' do
			ttt.send(:add_player, player_name_1)
			expect(ttt.players[0]).not_to eq(nil)
			ttt.send(:add_player, player_name_2)
			expect(ttt.players[1]).not_to eq(nil)
		end

		it 'players must be valid' do
			ttt.send(:add_player, player_name_1)
			expect(ttt.players[0].valid?).to eq(true)
			ttt.send(:add_player, player_name_2)
			expect(ttt.players[1].valid?).to eq(true)
		end

		it 'invalid player must not exist' do
			ttt.send(:add_player, invalid_player_name)
			expect(ttt.players[0]).to eq(nil)
		end

		it 'should have empty board' do
			expect(ttt.board.class).to eq(Board)
		end

		it 'must have first player in queue' do
			ttt.send(:add_player, player_name_1)
			ttt.send(:add_player, player_name_2)
			expect(ttt.player_in_queue).not_to eq(nil)
			expect(ttt.player_in_queue.name).to eq(player_name_1)
		end
	end

	context "check turns" do
		let(:player_name_1) { 'Gia' }
		let(:player_name_2) { 'Agi' }
		subject(:ttt){ described_class.new }

		
	end
end