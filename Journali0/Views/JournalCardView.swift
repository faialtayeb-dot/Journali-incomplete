//
//  JournalCardView.swift
//  Journali0
//
//  Created by Fai Altayeb on 22/10/2025.
//

import SwiftUI

struct JournalCardView: View {
    @EnvironmentObject private var journalViewModel: JournalViewModel
    var entry: JournalEntry
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: entry.date)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(entry.title)
                    .font(.headline)
                    .foregroundColor(.lightPurple)
                
                Spacer()
                
                Button {
                    journalViewModel.toggleBookmark(for: entry)
                } label: {
                    Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                        .foregroundColor(.lightPurple)
                }
                .buttonStyle(.plain)
            }
            
            Text(formattedDate)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(entry.content)
                .font(.body)
                .foregroundColor(.white)
                .lineLimit(4)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 2)
        
    }
}
