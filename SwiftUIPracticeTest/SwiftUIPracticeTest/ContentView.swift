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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus").imageScale(.large)
                    }
                }
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

#Preview {
    ContentView()
}
