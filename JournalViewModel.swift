//
//  ViewModel.swift
//  Journali0
//
//  Created by Fai Altayeb on 21/10/2025.
//

import Foundation
import SwiftUI
import Combine

final class JournalViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var filterBookmarked: Bool = false
    @Published var sortDescending: Bool = true
    @Published var entries: [JournalEntry] = []
    
    // ADD ENTRY:
    func addEntry(title: String, content: String) {
        let newEntry = JournalEntry(title: title, content: content)
        entries.append(newEntry)
    }
    
    // EDIT ENTRY:
    func updateEntry(_ entry: JournalEntry, newTitle: String, newContent: String) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index].title = newTitle
            entries[index].content = newContent
        }
    }
    
    // BOOKMARK:
    func toggleBookmark(for entry: JournalEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index].isBookmarked.toggle()
        }
    }
    
    func deleteEntry(_ entry: JournalEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries.remove(at: index)
        }
    }
    
    // FILTERED + SORTED:
    var filteredEntries: [JournalEntry] {
        var list = entries
        
        if filterBookmarked {
            list = list.filter { $0.isBookmarked }
        }
        
        if !searchText.isEmpty {
            list = list.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        
        return list.sorted { sortDescending ? $0.date > $1.date : $0.date < $1.date }
    }
    
    // THE SWIPE-TO-DELETE:
 
}

