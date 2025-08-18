//
//  ContentView.swift
//  SwiftUIPracticeTest
//
//  Created by zahraa zreik on 18/08/2025.
//

import SwiftUI

struct Book: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var author: String
    var isRead: Bool = false
}

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

struct ContentView: View {
    @StateObject var viewModel = BookViewModel()
    @State private var showingAdd = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(book.title).bold()
                                Text(book.author).font(.subheadline)
                            }
                            Spacer()
                            Button {
                                viewModel.toggleRead(book)
                            } label: {
                                Image(systemName: book.isRead ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(book.isRead ? .green : .gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Books")
            .toolbar {
                Button("+") { showingAdd = true }
            }
            .sheet(isPresented: $showingAdd) {
                AddBookView(viewModel: viewModel)
            }
            .navigationDestination(for: Book.self) { book in
                BookDetailView(book: book, viewModel: viewModel)
            }
        }
    }
}

struct AddBookView: View {
    @ObservedObject var viewModel: BookViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
            TextField("Author", text: $author)
                .textFieldStyle(.roundedBorder)
            
            Button("Save") {
                guard !title.isEmpty, !author.isEmpty else { return }
                viewModel.addBook(title: title, author: author)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Cancel") { dismiss() }
        }
        .padding()
    }
}

struct BookDetailView: View {
    var book: Book
    @ObservedObject var viewModel: BookViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text(book.title).font(.title)
            Text(book.author).foregroundColor(.secondary)
            
            Button(book.isRead ? "Mark as Unread" : "Mark as Read") {
                viewModel.toggleRead(book)
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
