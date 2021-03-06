
% replace: altera se possivel o contuedo do tabuleiro nas coordenadas X,Y
replace([L|Ls],0,X,Z,[R|Ls]):-replace_line(L,X,Z,R).
replace([L|Ls],Y,X,Z,[L|Rs]):-Y > 0, Y1 is Y-1, replace(Ls,Y1,X,Z,Rs).

replace_line([p|Cs],0,Z,[p|Cs]):-
  write('FALSE MOVE'),nl.
replace_line([b|Cs],0,Z,[b|Cs]):-
  write('FALSE MOVE'),nl.

replace_line([_|Cs],0,Z,[Z|Cs]).
replace_line([C|Cs],X,Z,[C|Rs]):-X > 0, X1 is X-1, replace_line(Cs,X1,Z,Rs).



%
return_value([L|Ls], X, 0, R):- return_value_line(L, X, R).
return_value([L|Ls], X, Y, R):- Y>0, Y1 is Y-1, return_value(Ls, X, Y1, R).

%
return_value_line([C|Cs], 0, C).
return_value_line([C|Cs], X, R):- X>0, X1 is X-1, return_value_line(Cs, X1, R).


% verifica se existem 5 peças seguidas horizontalmente à coordenada Y
verify_horizontal(T, PLAYER,INITIAL_X, X, Y, MAX_X, COUNT, GAME_END):-
  COUNT < 5,
  X > -1,
  return_value(T,X,Y,R),
  R=PLAYER,
  COUNT1 is COUNT+1,
  X1 is X-1,
  verify_horizontal(T, PLAYER,INITIAL_X, X1, Y, MAX_X, COUNT1, GAME_END).

verify_horizontal(T, PLAYER,INITIAL_X, X, Y, MAX_X, COUNT, GAME_END):-
  COUNT < 5,
  INITIAL_X1 is INITIAL_X+1,
  INITIAL_X1 < MAX_X,
  return_value(T, INITIAL_X1, Y, R),
  R=PLAYER,
  COUNT1 is COUNT+1,
  verify_horizontal(T, PLAYER,INITIAL_X1, X, Y, MAX_X, COUNT1, GAME_END).

verify_horizontal(T, PLAYER,INITIAL_X, X, Y, MAX_X, COUNT, GAME_END):-
  COUNT < 5,
  write('NEXT MOVE.'),nl.

verify_horizontal(T, PLAYER,INITIAL_X, X, Y, MAX_X, COUNT, GAME_END):-
  GAME_END = PLAYER,
  write('PLAYER '),
  traduz(PLAYER,V),
  write(V),
  write(' WON'),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

verify_diagonals_right(T, PLAYER,INITIAL_Y, X, Y, MAX_Y, COUNT, GAME_END):-
    COUNT < 5,
    Y > -1,
    return_value(T,X,Y,R),
    R=PLAYER,
    COUNT1 is COUNT+1,
    Y1 is Y-1,
    verify_diagonals_right(T, PLAYER,INITIAL_Y, X, Y1, MAX_Y, COUNT1, GAME_END).

  verify_diagonals_right(T, PLAYER,INITIAL_Y, X, Y, MAX_Y, COUNT, GAME_END):-
    COUNT < 5,
    INITIAL_Y1 is INITIAL_Y+1,
    INITIAL_Y1 < MAX_Y,
    return_value(T, X, INITIAL_Y1, R),
    R=PLAYER,
    COUNT1 is COUNT+1,
    verify_diagonals_right(T, PLAYER,INITIAL_Y1, X, Y, MAX_Y, COUNT1, GAME_END).

  verify_diagonals_right(T, PLAYER,INITIAL_Y, X, Y, MAX_Y, COUNT, GAME_END):-
    COUNT < 5,
    write('NEXT MOVE.'),nl.

  verify_diagonals_right(T, PLAYER,INITIAL_Y, X, Y, MAX_Y, COUNT, GAME_END):-
    GAME_END = PLAYER,
    write('PLAYER '),
    traduz(PLAYER,V),
    write(V),
    write(' WON'),nl.

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  verify_diagonals_left(T, PLAYER, INITIAL_X, INITIAL_Y, X, Y, MAX_X, MAX_Y, COUNT_D_L, GAME_END):-
    COUNT_D_L < 5,
    Y < MAX_Y,
    X > -1,
    return_value(T,X,Y,R),
    R=PLAYER,
    COUNT_D_L_1 is COUNT_D_L+1,
    X1 is X-1,
    Y1 is Y+1,
    verify_diagonals_left(T, PLAYER, INITIAL_X, INITIAL_Y, X1, Y1, MAX_X, MAX_Y, COUNT_D_L_1, GAME_END).

  verify_diagonals_left(T, PLAYER, INITIAL_X, INITIAL_Y, X, Y, MAX_X, MAX_Y, COUNT_D_L, GAME_END):-
    COUNT_D_L < 5,
    INITIAL_X1 is INITIAL_X+1,
    INITIAL_Y1 is INITIAL_Y-1,
    INITIAL_Y1 > -1,
    INITIAL_X1 < MAX_X,
    return_value(T, INITIAL_X1, INITIAL_Y1, R),
    R=PLAYER,
    COUNT_D_L_1 is COUNT_D_L+1,
    verify_diagonals_left(T, PLAYER,INITIAL_X1, INITIAL_Y1, X, Y, MAX_X, MAX_Y, COUNT_D_L_1, GAME_END).

  verify_diagonals_left(T, PLAYER, INITIAL_X, INITIAL_Y, X, Y, MAX_X, MAX_Y, COUNT_D_L, GAME_END):-
    COUNT_D_L < 5,
    write('NEXT MOVE.'),nl.

  verify_diagonals_left(T, PLAYER,INITIAL_X, INITIAL_Y, X, Y, MAX_X, MAX_Y, COUNT_D_L, GAME_END):-
    GAME_END = PLAYER,
    write('PLAYER '),
    traduz(PLAYER,V),
    write(V),
    write(' WON'),nl.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

verify_full_board(T, X, Y, MAX_X, MAX_Y, VERIFY, null):-
  write('NULL'),
  VERIFY is 0.

verify_full_board(T, X, Y, MAX_X, MAX_Y, VERIFY, I):-
  write('verifying'),
  X < MAX_X,
  Y < MAX_Y,
  return_value(T, X, Y, R),
  X1 is X+1,
  verify_full_board(T, X1, Y, MAX_X, MAX_Y, VERIFY, R).

verify_full_board(T, X, Y, MAX_X, MAX_Y, VERIFY, I):-
  Y < MAX_Y,
  Y1 is Y+1,
  MAX_X1 is MAX_X-1,
  verify_full_board(T, 0, Y1, MAX_X1, MAX_Y, VERIFY, I).

verify_full_board(T, X, Y, MAX_X, MAX_Y, VERIFY, I):-
  VERIFY is 2,
  write('TABULEIRO CHEIO!'),nl.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

playGame(T, MAX_X, MAX_Y, Z, COUNT, MODE, GAME_END, 1,DIFFICULTY):-
  verify_full_board(T, 0, 0, MAX_X, MAX_Y, VERIFY, p),
  playGame(T, MAX_X, MAX_Y, Z, COUNT, MODE, GAME_END, VERIFY,DIFFICULTY).

playGame(T, MAX_X, MAX_Y, Z, COUNT, MODE, GAME_END, 2):-
  display_board(T,14,2,1,0).

playGame(T, MAX_X, MAX_Y, Z, COUNT, MODE, GAME_END, VERIFY,DIFFICULTY):-
  GAME_END == b,
  write('PLAYER '),
  traduz(GAME_END,V),
  write(V),
  write(' WON'),nl.
  display_board(T,14,2,1,0).

playGame(T, MAX_X, MAX_Y, Z, COUNT, MODE, GAME_END, VERIFY,DIFFICULTY):-
  GAME_END == p,
  write('PLAYER '),
  traduz(GAME_END,V),
  write(V),
  write(' WON'),nl.
  display_board(T,14,2,1,0).

playGame(T, MAX_X, MAX_Y, b, COUNT, MODE, GAME_END, VERIFY,DIFFICULTY):-
  write('It is player '),
  traduz(b,V),
  write(V),
  write(' turn.'),nl,
  display_board(T,14,2,1,0),
  getCoordinates(T,X,Y,MAX_X,MAX_Y, b, MODE,DIFFICULTY),
  replace(T,Y,X,b,B),
  verify_horizontal(B,b,X,X,Y,MAX_X,COUNT, GAME_END),
  verify_diagonals_right(B,b,Y,X,Y, MAX_Y,COUNT,GAME_END),
  verify_diagonals_left(B,b,X,Y,X,Y,MAX_X,MAX_Y,COUNT,GAME_END),
  COUNT < 5,
  display_board(B,14,2,1,0),
  playGame(B, MAX_X, MAX_Y, p, COUNT,MODE, GAME_END, 1,DIFFICULTY).


playGame(T, MAX_X, MAX_Y, p, COUNT, MODE, GAME_END, VERIFY,DIFFICULTY):-
  write('It is player '),
  traduz(p,V),
  write(V),
  write(' turn.'),nl,
  display_board(T,14,2,1,0),
  getCoordinates(T,X,Y,MAX_X,MAX_Y, p, MODE,DIFFICULTY),
  replace(T,Y,X,p,B),
  verify_horizontal(B,p,X,X,Y,MAX_X,COUNT, GAME_END),
  verify_diagonals_right(B,p,Y,X,Y, MAX_Y,COUNT,GAME_END),
  verify_diagonals_left(B,p,X,Y,X,Y,MAX_X,MAX_Y,COUNT,GAME_END),
  COUNT < 5,
  display_board(B,14,2,1,0),
  playGame(B, MAX_X, MAX_Y, b, COUNT, MODE, GAME_END, 1,DIFFICULTY).


playGame(T, MAX_X, MAX_Y, b, COUNT, MODE, GAME_END, VERIFY,DIFFICULTY):-
  COUNT < 5,
  write('OUT OF RANGE'),nl.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
