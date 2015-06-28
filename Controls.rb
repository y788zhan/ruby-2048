# 2048 controls module

module Controls
=begin
controls: 
Up - w
Down - a
Left - s
Right - d
=end

def Controls.print_board(board)
	for line in board
		for val in line
			print '%6s' % val
		end
		print "\n"
	end
end
		 
def Controls.two_four()
	random = rand(10) + 1
	val = 2
	# 90% change to spawn 2, 10% change to spawn 4
	if random > 9
		val = 4
	end
	return val
end
		 
def Controls.notfullline?(line)
	notfull = false
	line.each do |val|
		if val = "."
			notfull = true
		end
	end
	return notfull
end

def Controls.getl(board)
	proceed = false
	for line in board
		if notfullline?(line)
			proceed = true
		end
	end
	if proceed
		random = rand(4)
		if notfullline?(board[random])
			return random
		else
			Controls.getl(board)
		end
	else
		return proceed
	end
end

def Controls.getc(board)
	state = Controls.getl(board)
	if state == false
		return false
	else 
		random = rand(4)
		if board[state][random] == "."
			board[state][random] = Controls.two_four()
		else
			Controls.getc(board)
		end
	end
end

def Controls.initialize(board)
	# generate 2 random numbers on board upon play
	Controls.getc(board)
	Controls.getc(board)
end

def Controls.closegapright(line)
	numbers = line.select {|x| x != "."}
	empty = 4 - numbers.length
	while empty > 0 do
		numbers.unshift(".")
		empty -= 1
	end
	for i in 0..3
		line[i] = numbers[i]
	end
end

def Controls.moverightline(line)
	# move logic is close gap, then merge, then close gap again
	Controls.closegapright(line)
	if line[3] != "." && line[3].to_i == line[2].to_i
		line[3] = line[3].to_i
		line[3] *= 2
		line[3] = line[3].to_s
		line[2] = "."
	end
	if line[2] != "." && line[2].to_i == line[1].to_i
		line[2] = line[2].to_i
		line[2] *= 2
		line[2] = line[2].to_s
		line[1] = "."
	end
	if line[1] != "." && line[1].to_i == line[0].to_i
		line[1] = line[1].to_i
		line[1] *= 2
		line[1] = line[1].to_s
		line[0] = "."
	end
	Controls.closegapright(line)
end

def Controls.moveright(board)
	for line in board
		Controls.moverightline(line)
	end
end

def Controls.moveleftline(line)
	line.reverse!
	Controls.moverightline(line)
	line.reverse!
end

def Controls.moveleft(board)
	# moveleft equivalent to reverse of moveright
	for line in board
		Controls.moveleftline(line)
	end
end

def Controls.mytranspose(from, to)
	for i in 0..3
		for j in 0..3
			to[i][j] = from[j][i]
		end
	end
end

def Controls.untranspose(from, to)
	for i in 0..3
		for j in 0..3
			to[i][j] = from[j][i]
		end
	end
end

def Controls.moveup(board, temp)
	# moveup is equivalent to moveleft of transposed board
	Controls.mytranspose(board, temp)
	Controls.moveleft(temp)
	Controls.untranspose(temp,board)
end

def Controls.movedown(board, temp)
	# movedown is equivalent to moveright of transposed board
	Controls.mytranspose(board, temp)
	Controls.moveright(temp)
	Controls.untranspose(temp,board)
end

def Controls.board_equal(b1, b2)
	equal = true
	for i in 0..3
		for j in 0..3
			if b1[i][j] != b2[i][j]
				return false
			end
		end
	end
	return equal
end

def Controls.continue?(orig, board, temp)
	for i in 0..3
		for j in 0..3
			orig[i][j] = board[i][j]
		end
	end
	# try all 4 possible moves, and check if any move can change the board
	Controls.moveright(board)
	right = Controls.board_equal(orig, board)
	Controls.moveleft(board)
	left = Controls.board_equal(orig, board)
	Controls.moveup(board, temp)
	up = Controls.board_equal(orig, board)
	Controls.movedown(board, temp)
	down = Controls.board_equal(orig, board)
	# revert the board
	for i in 0..3
		for j in 0..3
			board[i][j] = orig[i][j]
		end
	end
	return !(right && left && up && down)
end
	

def Controls.play(board, temp, prev, orig)
	Controls.initialize(board)
	Controls.print_board(board)
	puts "-" * 30
	while Controls.continue?(orig, board, temp)
		for i in 0..3
			for j in 0..3
				prev[i][j] = board[i][j]
			end
		end
		puts "Your move:"
		command = gets.chomp
		if command == "w"
			Controls.moveup(board, temp)
		elsif command == "a"
			Controls.moveleft(board)
		elsif command == "s"
			Controls.movedown(board, temp)
		elsif command == "d"
			Controls.moveright(board)
		elsif command == "exit"
			break
		end
		if !Controls.board_equal(board, prev)
			# if board remains the same after a move, then the move is deemed invalid. User is prompted for another move
			Controls.getc(board)
			puts "-" * 30
			Controls.print_board(board)
		end
	end
	puts "Game over"
end

end