% Nathan Driscoll z5204935 COMP3411 Assignment 2 - Part 2: Inductive Logic Programming 

:- op(300, xfx, <-).
inter_construction(C1 <- B1, C2 <- B2, C1 <- Z1B, C2 <- Z2B, C <- B) :-
    C1 \= C2,
    intersection(B1, B2, B),
    gensym(z, C),
    subtract(B1, B, B11),
    subtract(B2, B, B12),
    append(B11, [C], Z1B),
    append(B12, [C], Z2B).

% 2.1
intra_construction(C1 <- B1, C1 <- B2, C1 <- C2B, C2 <- A1, C2 <- A2) :-
    C1 == C1,
    intersection(B1, B2, B),
    reset_gensym(),
    gensym(z, C2),
    subtract(B1, B, A1),
    subtract(B2, B, A2),
    append(B, [C2], C2B).

% 2.2
% first is subset of second - first unchanged
absorption(C1 <- B1, C2 <- B2, C1 <- B1, C2 <- A1) :-
    C1 \= C2,
    subset(B1, B2),
    subtract(B2, B1, B3),
    append([C1], B3, A1).
% second is subset of first - second unchanged
absorption(C1 <- B1, C2 <- B2, C1 <- A1, C2 <- B2) :-
    C1 \= C2,
    subset(B2, B1),
    subtract(B1, B2, B3),
    append([C2], B3, A1).

% 2.3
% first has 1 symbol that doesn't appear in other
identification(C1 <- B1, C1 <- B2, [[B11]] <- B3, C1 <- B11B) :-
    intersection(B1, B2, B),
    subtract(B1, B, [B11]), % [] around B11 takes the square brackets away from result is not a list and also must be 1 element
    append(B, B11, B11B),
    subtract(B2, B, B3).
% second has 1 symbol that doesn't appear in other
identification(C1 <- B1, C1 <- B2, C1 <- B11B, B11 <- B3) :-
    intersection(B1, B2, B),
    subtract(B2, B, [B11]),
    append(B, [B11], B11B),
    subtract(B1, B, B3).

% 2.4
dichotomisation(C1 <- B1, not(C1) <- B2, C1 <- A1, not(C1) <- A2, C2 <- A3, not(C2) <- A4) :-
    intersection(B1, B2, B),
    reset_gensym(),
    gensym(z, C2),
    append(B, [C2], A1),
    append(B, [not(C2)], A2),
    subtract(B1, B, A3),
    subtract(B2, B, A4).

% 2.5
truncation(C1 <- B1, C1 <- B2, C1 <- B) :-
    intersection(B1, B2, B).