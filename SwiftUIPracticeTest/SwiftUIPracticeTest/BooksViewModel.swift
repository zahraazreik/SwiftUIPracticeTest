//
//  BooksViewModel.swift
//  SwiftUIPracticeTest
//
//  Created by zahraa zreik on 19/08/2025.
//

import SwiftUI

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    
    func addBook(title: String, author: String) {
        books.append(Book(title: title, author: author))
    }
    
    func toggleRead(_ book: Book) {
        if let i = books.firstIndex(of: book) {
            books[i].isRead.toggle()
        }
    }
}
