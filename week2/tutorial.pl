% q1
female(pam).
female(liz).
female(pat).
female(ann).
male(tom).
male(bob).
male(jim).

parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

mother(Parent, Child) :- parent(Parent, Child), female(Parent).
father(Parent, Child) :- parent(Parent, Child), male(Parent).

grandparent(X, Z) :- parent(X, Y), parent(Y, Z).

sister(Sister, Sibling) :-
    parent(P, Sister),
    parent(P, Sibling),
    female(Sister),
    Sister \= Sibling.

% person 1 is ancestor of person 2 - person 1 older than person 2
% base case - person 1 is parent of person 2
ancestor(Person1, Person2) :-
    parent(Person1, Person2).
% recursive case - person1 is parent of person 3, use person 3 as top ancestor - go down the family tree
ancestor(Person1, Person2) :-
    parent(Person1, Person3),
    ancestor(Person3, Person2).

% q2
% insert(Num, List, NewList)
% note: notation insert/3 means predicate insert takes 3 arguments
% base case
insert(Num, [], [Num]).
% recursive cases - num is <= head - put it at the start
insert(Num, [Head|Tail], [Num, Head | Tail]) :-
    Num =< Head.
% num > head, insert num into tail somewhere, result into newtail
insert(Num, [Head|Tail], [Head|Newtail]) :-
    Num > Head,
    insert(Num, Tail, Newtail).

% q3
% isort(List, NewList) where NewList is sorted
% base case
isort([], []).
% recursive case - sort tail then insert head to make sorted list
isort([Head|Tail], NewList) :-
    isort(Tail, TailSorted),
    insert(Head, TailSorted, NewList).

% q4 
% predicate split(BigList, List1, List2) 
% base case
split([], [], []).
% one element
split([A], [A], []).
% recursive case
split([Head, Second|Tail], [Head|List1], [Second|List2]) :-
    split(Tail, List1, List2).

% q5
% merge(Sort1, Sort2, Sort) - combine sorted lists Sort1 and Sort2 into Sort
% base case - if one list is empty return the other list - covers 2 empty lists
merge2(X, [], X).
merge2([], X, X).
% recursive case
merge2([H1|T1], List2, Sorted) :-
    merge2(T1, List2, Merged), % merge tail of first list with list 2
    insert(H1, Merged, Sorted). % insert head of first list into seond list to create NewList

% but this is quadratic complexity because we may have to go through the whole merged list. If n = sizeof list 1, m list 2: O(m(n + m))

% here is linear - O(n+m). Compares both lists to find smaller element
% base case
merge2(X, [], X).
merge2([], X, X).
% recursive case
merge2([H1|T1], [H2|T2], [H1|T]) :-
    H1 =< H2,
    merge(T1, [H2|T2], [H1|T]).
merge2([H1|T1], [H2|T2], [H2|T]) :-
    H1 > H2,
    merge([H1|T1], T2, T).