//
//  BookDetailView.swift
//  SwiftUIPracticeTest
//
//  Created by zahraa zreik on 19/08/2025.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    @ObservedObject var viewModel: BookViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text(book.title).font(.title)
            Text(book.author).foregroundColor(.secondary)
            
            Button(book.isRead ? "Mark as Unread" : "Mark as Read") {
                viewModel.toggleRead(book)
                dismiss()
            }
            .buttonStyle(.bordered)
            
            Spacer()
        }
        .padding()
    }
}
