//
//  AddEntryView.swift
//  Journali0
//
//  Created by Fai Altayeb on 22/10/2025.
//

import SwiftUI

struct AddEntryView: View {
    var entryToEdit: JournalEntry? = nil
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var journalViewModel: JournalViewModel
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var showDiscardAlert = false
    
    private var date = Date()
    private var formattedDate: String {
        let Formatter = DateFormatter()
        Formatter.dateFormat = "dd/MM/yyyy"
        return Formatter.string(from: date)
    }
    init(entryToEdit: JournalEntry? = nil) {
        self.entryToEdit = entryToEdit
        _title = State(initialValue: entryToEdit?.title ?? "")
        _content = State(initialValue: entryToEdit?.content ?? "")
    }
    
    private var hasChanges: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var canSave: Bool {
        hasChanges
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Title", text: $title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(formattedDate)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            TextEditor(text: $content)
                .overlay(
                    Group {
                        if content.isEmpty {
                            Text("Type your Journal...")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.horizontal, 4)
                                .allowsHitTesting(false)
                        }
                    },
                    alignment: .topLeading
                )
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    if hasChanges {
                        showDiscardAlert = true
                    } else {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                }
                .tint(.primary)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)

                    if let entryToEdit = entryToEdit {
                        // EDIT MODE
                        journalViewModel.updateEntry(entryToEdit, newTitle: trimmedTitle, newContent: trimmedContent)
                    } else {
                        // ADD MODE
                        journalViewModel.addEntry(title: trimmedTitle, content: trimmedContent)
                    }

                    dismiss()
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                }
                .tint(.buttonPurple)
                .disabled(!canSave)
            }
        }
        .alert("Are you sure you want to discard changes on this journal?",
               isPresented: $showDiscardAlert) {
            Button("Discard Changes", role: .destructive) {
                dismiss()
            }
            Button("Keep Editing", role: .cancel) { }
        }
    }
}
