#!/usr/bin/env ruby
$LOAD_PATH << './lib'


RSpec.describe TicTacToe do

	context "check initialize" do
		let(:player_name_1) { 'Gia' }
		let(:player_name_2) { 'Agi' }
		let(:invalid_player_name) { 'Gi' }
		let(:player1) { instance_double('Player', name: player_name_1, index: subject.players.size, valid?: true) }
		let(:player2) { instance_double('Player', name: player_name_2, index: subject.players.size, valid?: true) }
		let(:invalid_player) { instance_double('Player', name: player_name_2, index: subject.players.size, valid?: false) }

		it 'players must be set' do
			subject.add_player(player1)
			expect(subject.players[0]).not_to eq(nil)
			subject.add_player(player2)
			expect(subject.players[1]).not_to eq(nil)
		end

		it 'must be only 2 players' do
			subject.add_player(player1)
			subject.add_player(player2)
			subject.add_player(player2)
			expect(subject.players.size).to eq(2)
			expect(subject.players[2]).to eq(nil)
		end

		it 'players must be valid' do
			subject.add_player(player1)
			expect(subject.players[0].valid?).to eq(true)
			subject.add_player(player2)
			expect(subject.players[1].valid?).to eq(true)
		end

		it 'invalid player must not exist' do
			subject.add_player(invalid_player)
			expect(subject.players[0]).to eq(nil)
		end

		it 'board should be set after initialize' do
			expect(subject.board.class).to eq(Board)
		end

		it 'must have first player in queue' do
			subject.add_player(player1)
			expect(subject.player_in_queue).not_to eq(nil)
			expect(subject.player_in_queue.name).to eq(player_name_1)
		end
	end

	context "player and turns" do
		let(:player_name_1) { 'Gia' }
		let(:player_name_2) { 'Agi' }
		let(:valid_move){ 'a1' }
		let(:player1) { instance_double('Player', name: player_name_1, index: subject.players.size, valid?: true) }
		let(:player2) { instance_double('Player', name: player_name_2, index: subject.players.size, valid?: true) }
		let(:valid_turns) { ['a1', 'a2', 'a3', 'b1', 'b2', 'b3', 'c1', 'c2', 'c3'] }
		
		it "always true for valid moves" do
			valid_turns.each do |turn|
				expect(subject.validate(turn)).to be_truthy
			end
		end

		it "should always be false for random strings" do
			13.times do
				expect(subject.validate(Faker::String.random(length: rand(1..4)))).to be_falsey
			end
		end
		
		it 'should give players correct last move' do
			subject.add_player(player1)
			subject.add_player(player2)
			subject.current_input = valid_move
			allow(subject).to receive(:save_turn)
			subject.save_turn		
			subject.increase_turn
			allow(subject.player_in_queue).to receive(:moves).and_return(['a1'])
			expect(subject.player_in_queue.moves[0]).to eq(valid_move)
		end


		it 'should change player in queue' do
			subject.add_player(player1)
			subject.add_player(player2)
			subject.current_input = valid_move
			allow(subject).to receive(:save_turn)
			subject.save_turn	
			subject.increase_turn
			expect(subject.player_in_queue).to eq(player1)
			subject.queue_player
			expect(subject.player_in_queue).to eq(player2)
		end
	end

	context "game states" do
		let(:player_name_1) { 'Gia' }
		let(:player_name_2) { 'Agi' }
		let(:player1) { instance_double('Player', name: player_name_1, index: subject.players.size, valid?: true, add_point: true) }
		let(:player2) { instance_double('Player', name: player_name_2, index: subject.players.size, valid?: true, add_point: true) }
		let(:valid_move){ 'a1' }

		it "player 1 wins" do
			subject.add_player(player1)
			subject.add_player(player2)
			
			['a1', 'a2', 'b1', 'c3', 'c1'].each do |turn|
				subject.current_input = turn
				subject.board.board[%w[a b c].index(turn[0])][turn[1].to_i - 1] = subject.turn.modulo(2)
				subject.increase_turn
				subject.queue_player
			end
			expect(subject.board.winner_line?).to eq(0)
			expect(subject.board.full?).to eq(false)
		end
	end
end
