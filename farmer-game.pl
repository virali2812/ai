% unsafe_state predicate - we need to ensure that there is no state in which the fox is alone with the hen, and the hen is alone with the grain.
unsafe_state([X, Y, Y, _]) :- X \== Y.
unsafe_state([X, _, Y, Y]) :- X \== Y.

% initial_state and goal_state predicate.
initial_state([yard, yard, yard, yard]).
goal_state([market, market, market, market]).

% legal_move predicate -  we need to ensure that the move is valid, i.e., that it does not result in something being eaten in the new state.
legal_move([yard,X,Y,Z], go_alone(market), [market,X,Y,Z]).
legal_move([market,X,Y,Z], come_back_alone(yard), [yard,X,Y,Z]).

legal_move([yard,X,yard,Z], go_with(hen, market), [market,X,market,Z]).
legal_move([market,X,market,Z], come_back_with(hen,yard), [yard,X,yard,Z]).

legal_move([yard, yard, X, Y], go_with(fox, market), [market, market, X, Y]).
legal_move([market, market, X, Y], come_back_with(fox,yard), [yard, yard, X, Y]).

legal_move([yard, X, Y, yard], go_with(grains,market), [market, X, Y, market]).
legal_move([market, X, Y, market], come_back_with(grains,yard), [yard, X, Y, yard]).
	
plan(M1, M2, M3, M4, M5, M6, M7) :- initial_state(I), goal_state(G), reachable(I, G, [I], [M1, M2, M3, M4, M5, M6, M7]).

reachable(S,S,_,[]).
reachable(S1,S3,V,[M|L]) :- legal_move(S1,M,C), not(unsafe_state(C)), not(member(C,V)), reachable(C,S3,[C|V],L).