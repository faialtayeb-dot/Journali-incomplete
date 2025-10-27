//
//  Model.swift
//  Journali0
//
//  Created by Fai Altayeb on 20/10/2025.
//

import SwiftUI
import Foundation

struct JournalEntry: Identifiable, Hashable {
    let id: UUID
    var title: String
    var date: Date
    var content: String
    var isBookmarked: Bool = false
    
    init(id: UUID = UUID(), title: String, date: Date = Date(), content: String) {
        self.id = id
        self.title = title
        self.date = date
        self.content = content
    }
}
