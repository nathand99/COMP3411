% Nathan Driscoll z5204935 COMP3411 Assignment 1 - Prolog and Search
:- set_prolog_flag(answer_write_options,[max_depth(0)]).

% 1.1 List processing
% sum the squares of the even numbers in the list
sumsq_even([], 0).
% case head is even - add its square to sum
sumsq_even([Head|Tail], Sum) :-
    sumsq_even(Tail, TailSum),
    0 is Head mod 2,
    Sum is Head * Head + TailSum.
% case head is odd - do not anything to sum
sumsq_even([Head|Tail], Sum) :-
    sumsq_even(Tail, TailSum),
    1 is Head mod 2,
    Sum is TailSum.

    % Sum = Head + TailSum. gives output Sum = 1+ (3+ (5+0)).

% 1.2 List processing
% eliza1 - takes in a list of words, prepends "what makes you say" and replaces:
% you -> i
% me -> you
% my -> your
% assuming that all given sentences start with "you" and "you" only occurs once in a sentence
eliza1([], []).
eliza1([Head|Tail], [what, makes, you, say, i | NewTail]) :-
    Head == you,
    eliza1(Tail, NewTail).

eliza1([Head|Tail], [you | NewTail]) :-
    Head == me,
    eliza1(Tail, NewTail).

eliza1([Head|Tail], [your | NewTail]) :-
    Head == my,
    eliza1(Tail, NewTail).

eliza1([Head|Tail], [Head | NewTail]) :-
    Head \== you,
    Head \== me,
    Head \== my,
    eliza1(Tail, NewTail).

% 1.3: List Processing
% eliza2 - takes [ ..., you, <some words>, me, ...] -> [what, makes, you, think, i, <some words>, you]
% use append
eliza2([], []).
eliza2(Sentence, Result) :-
    append(X, [me|_], Sentence), % cut off everything after and including me. Remaining list -> X
    append(_, [you|Words], X), % cut off everything before and including you
    append(Words, [you], End), % add "you" after words
    append([what, makes, you, think, i], End, Result). % add "what makes you think i" before words

% 1.4: Prolog Terms1
% eval
% eval(Expr, Val).
%:- op(1100, yfx, eval).

eval(mul(X, Y), V) :- 
    eval(X, A),
    eval(Y, B),
    V is A * B.
eval(div(X, Y), V) :- 
    eval(X, A),
    eval(Y, B),
    V is A / B.
eval(add(X, Y), V) :- 
    eval(X, A),
    eval(Y, B),
    V is A + B.
eval(sub(X, Y), V) :- 
    eval(X, A),
    eval(Y, B),
    V is A - B.
eval(X, X) :- 
    number(X).

