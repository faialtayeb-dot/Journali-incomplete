//
//  home.swift
//  Journali0
//
//  Created by Fai Altayeb on 20/10/2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var journalViewModel = JournalViewModel()
    
    @State private var entrySheet = false
    @State private var showDeleteAlert = false
    @State private var entryToDelete: JournalEntry? = nil
    @State private var showEditSheet = false
    @State private var selectedEntry: JournalEntry? = nil
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 0) {
                if journalViewModel.entries.isEmpty {
                    // No entries at all
                    VStack(spacing: 34) {
                        Image(.book)
                            .resizable()
                            .frame(width: 155, height: 110)
                        
                        VStack(alignment: .center, spacing: 13) {
                            Text("Begin Your Journal")
                                .foregroundColor(.lightPurple)
                                .fontWeight(.bold)
                                .font(.system(size: 24))
                            
                            Text("Craft your personal diary, tap the plus icon to begin")
                                .fontWeight(.light)
                                .kerning(0.6)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18))
                                .frame(width: 282)
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                else if journalViewModel.filteredEntries.isEmpty {
                  
                    VStack(spacing: 16) {
                     

                        Text("No journals found")
                            .font(.title3)
                            .foregroundColor(.gray.opacity(0.8))
                    }
                    .frame(maxHeight: .infinity)
                }
                else {
                  
                    List {
                        ForEach(journalViewModel.filteredEntries) { entry in
                            Button {
                                selectedEntry = entry
                                showEditSheet = true
                            } label: {
                                JournalCardView(entry: entry)
                                    .environmentObject(journalViewModel)
                                    .listRowInsets(EdgeInsets())
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                            }
                        }
                        .onDelete(perform: deleteEntry)
                    }
                    .listStyle(.plain)
                    .scrollDismissesKeyboard(.interactively)
                }


             
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Search journals...", text: $journalViewModel.searchText)
                        .textFieldStyle(.plain)
                        .padding(8)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }
                .padding()
                .background(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, y: -2)
            }

            .padding(.horizontal)
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Button("Sort by Bookmark") {
                            journalViewModel.filterBookmarked = true
                        }
                        
                        Button("Sort by Entry Date") {
                            
                            journalViewModel.sortDescending.toggle()
                            
                        }
                        
                        
                    } label: {
                        Image(systemName: "line.3.horizontal")
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        entrySheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                
            }
            
            .sheet(isPresented: $entrySheet) {
                NavigationStack {
                    AddEntryView()
                        .environmentObject(journalViewModel)
                }
            }
            .alert("Delete Journal?", isPresented: $showDeleteAlert, presenting: entryToDelete) { entry in
                Button("Delete", role: .destructive) {
                    journalViewModel.deleteEntry(entry)
                }
                Button("Cancel", role: .cancel) { }
            } message: { entry in
                Text("Are you sure you want to delete this journal?")
            }
            .sheet(isPresented: $showEditSheet) {
                if let entry = selectedEntry {
                    NavigationStack {
                        AddEntryView(entryToEdit: entry)
                            .environmentObject(journalViewModel)
                    }
                }
            }

        }
    }
    private func deleteEntry(at offsets: IndexSet) {
        if let index = offsets.first {
            entryToDelete = journalViewModel.filteredEntries[index]
            showDeleteAlert = true
        }
    }
}

#Preview {
    MainView()
}
