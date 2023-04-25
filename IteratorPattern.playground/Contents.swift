import UIKit

// Iterator Pattern


// The iterator pattern is a behavioral pattern that provides a standard way to loop through a collection.

// when to use

//Use the iterator pattern when you have a type that holds onto a group of objects, and you want to make them iterable using a standard for in syntax.

protocol StringIterator {
    func next() -> String?
}

class ArrayStringIterator: StringIterator {
    private let values: [String]
    private var index = 0
    
    init(_ values: [String]){
        self.values = values
    }
    
    func next() -> String? {
        defer{ self.index += 1 }
        return values.count > index ? values[index] : nil

    }
}

let objs = ArrayStringIterator(["Atchu","Girish","Naveen"])
while let next = objs.next() {
    print(next)
}


// iOS default have an IteartorProtocol or we can use Sequence Protocol for this same iteration

struct Book {
    let title: String
    let author: String
}

struct Books {
    let category: String
    let books: [Book]
}

struct BooksIterator: IteratorProtocol {
    private let books: [Book]
    private var current = 0
    init(_ books: [Book]) {
        self.books = books
    }
    mutating func next() -> Book? {
        defer{ current += 1}
        return books.count > current ? books[current] : nil
    }

}
let book1 = Book(title: "Design Pattern", author: "kodeco")
let book2 = Book(title: "SwiftUI", author: "Paul")
var books = BooksIterator([book1,book2])

// we can use simply Sequnce since it's an higer odre function we can get all the Higher oder functions as well
extension Books: Sequence {
    func makeIterator() -> BooksIterator {
        return BooksIterator(books)
    }
}


let bs = Books(category: "iOS", books: [book1,book2])
for b in bs {
    print(b.author)
}

// we can use collection as well
