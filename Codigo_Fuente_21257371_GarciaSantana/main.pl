% Pixbit

pixbit-d(X, Y, Bit, Profundidad, [X,Y,Bit,Profundidad]):-
    integer(X),
    integer(Y),
    integer(Bit),
    Bit = 1; Bit = 0,
    integer(Profundidad).

pixhex-d(X, Y, Color, Profundidad, [X,Y,Color,Profundidad]):-
    integer(X),
    integer(Y),
    string(Color),
    integer(Profundidad).

