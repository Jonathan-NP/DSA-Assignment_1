import ballerina/io;

LibraryManagementClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    Book createBookRequest = {Title: "Things Fall Apart", Author: ["Chinua Achebe"]};
    Responds createBookResponse = check ep->createBook(createBookRequest);
    io:println(createBookResponse);

    Book updateBookRequest = {Title: "The Rules of Thinking", Author: ["Richard Templar"]};
    Responds updateCourseResponse = check ep->updateBook(updateBookRequest);
    io:println(updateCourseResponse);

    string getBookByTitleRequest = "Things Fall Apart";
    Book getBookByTitleResponse = check ep->getBookByTitle(getBookByTitleRequest);
    io:println(getBookByTitleResponse);

    string deleteBookRequest = "The Rules of Thinking";
    Responds deleteBookResponse = check ep->deleteBook(deleteBookRequest);
    io:println(deleteBookResponse);
    stream<

    Book, error?> getAllBooksResponse = check ep->getAllBooks();
    check getAllBooksResponse.forEach(function(Book value) {
        io:println(value);
    });
}