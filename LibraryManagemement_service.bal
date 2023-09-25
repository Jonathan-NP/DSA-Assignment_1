import ballerina/grpc;

listener grpc:Listener ep = new (9090);

table<Book> key(Title) BookTable = table [];

@grpc:Descriptor {value: Library_DESC}
service "libraryManagement" on ep {

    remote function createBook(Book value) returns Responds|error {
        error? addNewBook = BookTable.add(value);
        if addNewBook is error {
            return addNewBook;
        } else {
            return {message: "Book saved successfully"};
        }
    }
    remote function updateBook(Book value) returns Responds|error {
        error? addNewBook = BookTable.put(value);
        if addNewBook is error {
            return addNewBook;
        } else {
            return {message: "Book updated successfully"};
        }
    }
    remote function getBookByTitle(string value) returns Book|error {
        Book getLecturer = BookTable.get(value);
        if (getBook.Title === "") {
            return error("Book cannot found");
        } else {
            return getBook;
        }
    }
    remote function deleteBook(string value) returns Responds|error {
        Book deletedLecturer = BookTable.remove(value);
        return {
            message: string `${deletedBook.Title} deleted successfully`
        };
    }

    remote function getAllBooks() returns stream<Book, error?>|error {
        stream<Book, error?> BookStream = stream from var Book in BookTable.toArray()
            select Book;

        return BookStream;
    }
}