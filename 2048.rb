# 2048 simulator

require "./Controls.rb"

=begin
controls: 
Up - W
Down - S
Left - A
Right - D
=end

orig = [[".", ".", ".", "."], # first line
		[".", ".", ".", "."], # second line
		[".", ".", ".", "."], # third line
		[".", ".", ".", "."]] # fourth line


temp = [[".", ".", ".", "."], # first line
		[".", ".", ".", "."], # second line
		[".", ".", ".", "."], # third line
		[".", ".", ".", "."]] # fourth line

prev = [[".", ".", ".", "."], # first line
		[".", ".", ".", "."], # second line
		[".", ".", ".", "."], # third line
		[".", ".", ".", "."]] # fourth line
		
board = [[".", ".", ".", "."], # first line
	     [".", ".", ".", "."], # second line
	     [".", ".", ".", "."], # third line
	     [".", ".", ".", "."]] # fourth line


Controls.play(board, temp, prev, orig)
