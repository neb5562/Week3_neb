#!/usr/bin/env ruby
$LOAD_PATH << './lib'


RSpec.describe TicTacToe do

	context "check initialize" do
		let(:player_name_1) { 'Gia' }
		let(:player_name_2) { 'Agi' }
		let(:invalid_player_name) { 'Gi' }
		subject(:ttt){ described_class.new }
		let(:player1) { instance_double('Player', name: player_name_1, index: ttt.players.size, valid?: true) }
		let(:player2) { instance_double('Player', name: player_name_2, index: ttt.players.size, valid?: true) }
		let(:invalid_player) { instance_double('Player', name: player_name_2, index: ttt.players.size, valid?: false) }

		it 'players must be set' do
			ttt.add_player(player1)
			expect(ttt.players[0]).not_to eq(nil)
			ttt.add_player(player2)
			expect(ttt.players[1]).not_to eq(nil)
		end

		it 'players must be valid' do
			ttt.add_player(player1)
			expect(ttt.players[0].valid?).to eq(true)
			ttt.add_player(player2)
			expect(ttt.players[1].valid?).to eq(true)
		end

		it 'invalid player must not exist' do
			ttt.add_player(invalid_player)
			expect(ttt.players[0]).to eq(nil)
		end

		it 'board should be set after initialize' do
			expect(ttt.board.class).to eq(Board)
		end

		it 'must have first player in queue' do
			ttt.add_player(player1)
			expect(ttt.player_in_queue).not_to eq(nil)
			expect(ttt.player_in_queue.name).to eq(player_name_1)
		end
	end

	context "check turns" do
		let(:player_name_1) { 'Gia' }
		let(:player_name_2) { 'Agi' }
		let(:player1) { instance_double('Player', name: player_name_1, index: ttt.players.size, valid?: true) }
		let(:player2) { instance_double('Player', name: player_name_2, index: ttt.players.size, valid?: true) }
		subject(:ttt){ described_class.new }

		it 'should give players correct last move' do
			ttt.add_player(player1)
			ttt.add_player(player2)
			expect(ttt.player_in_queue).to receive(:add_move).with(ttt.turn, 'a1')
			ttt.player_in_queue.add_move(ttt.turn, 'a1')
			ttt.increase_turn
			allow(ttt.player_in_queue).to receive(:moves).and_return(['a1', 'a2'])
			expect(ttt.player_in_queue.moves[0]).to eq('a1')
		end

		it 'should validate if move is valid' do
			ttt.add_player(player1)
			ttt.add_player(player2)
			expect(ttt.player_in_queue).to receive(:add_move).with(ttt.turn, 'a1')
			ttt.player_in_queue.add_move(ttt.turn, 'a1')
			ttt.increase_turn
			expect(ttt.validate('a1')).to be_truthy
			expect(ttt.validate('a4')).to be_falsey
			expect(ttt.validate('c4')).to be_falsey
			expect(ttt.validate('c2')).to be_truthy
			expect(ttt.validate('nk5')).to be_falsey
		end

		it 'should change player in queue' do
			ttt.add_player(player1)
			ttt.add_player(player2)
			expect(ttt.player_in_queue).to receive(:add_move).with(ttt.turn, 'a1')
			ttt.player_in_queue.add_move(ttt.turn, 'a1')
			ttt.increase_turn
			expect(ttt.player_in_queue).to eq(player1)
			ttt.queue_player
			expect(ttt.player_in_queue).to eq(player2)
		end

		# it 'should give players last move' do
		# 	ttt.add_player(Player.new(player_name_1, ttt.players.size))
		# 	ttt.add_player(Player.new(player_name_2, ttt.players.size))
		# 	ttt.player_in_queue.add_move(ttt.turn, 'a1')
		# 	ttt.increase_turn
		# 	# ttt.queue_player
		# 	ttt.player_in_queue.add_move(ttt.turn, 'a1')
		# 	expect(ttt.player_in_queue.moves[ttt.turn[1]]).to eq(nil)
		# end
	end
end
