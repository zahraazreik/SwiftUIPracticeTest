//
//  AddBookView.swift
//  SwiftUIPracticeTest
//
//  Created by zahraa zreik on 19/08/2025.
//

import SwiftUI

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
