livro('Os Maias').
book('Os Maias').

writer('Eça de Queiroz').
% wrote(writer, book).
wrote('Eça de Queiroz', 'Os Maias').

% nationality(writer, nationality)
nationality('Eça de Queiroz', portuguese).

% bookGenre(book, genre)
bookGenre('Os Maias', novel).

%bookType(book, type)
bookType('Os Maias', fiction).

writerNationalityByGenre(Writer, Nationality, Genre):-
    writer(Writer),
    bookGenre(Writer, Genre),
    nationality(Writer, Nationality).

booksOtherThanFiction(Writer):-
    wrote(Writer, Book1),
    wrote(Writer, Book2),
    Book1 \= Book2,
    bookType(Book1, fiction),
    bookType(Book2, Genre),
    Genre \= fiction.
