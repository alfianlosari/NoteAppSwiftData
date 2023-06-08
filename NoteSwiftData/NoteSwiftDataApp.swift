//
//  NoteSwiftDataApp.swift
//  NoteSwiftData
//
//  Created by Alfian Losari on 07/06/23.
//

import SwiftData
import SwiftUI

@main
struct NoteSwiftDataApp: App {
    
    @State var noteSearchText = ""
    @State var noteSortBy = NoteSortBy.createdAt
    @State var noteOrderBy = OrderBy.descending
    
    @State var tagSearchText = ""
    @State var tagOrderBy = OrderBy.ascending
    
    var body: some Scene {
        WindowGroup {
            TabView {
                noteList
                tagList
            }
            .modelContainer(for: [
                Note.self,
                Tag.self
            ])
        }
    }
    
    var noteList: some View {
        NavigationStack {
            NoteListView(allNotes: noteListQuery)
                .searchable(text: $noteSearchText, prompt: "Search")
                .textInputAutocapitalization(.never)
                .navigationTitle("Notes")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Picker("Sort by", selection: $noteSortBy) {
                                ForEach(NoteSortBy.allCases) {
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(noteSortBy.text, systemImage: "line.horizontal.3.decrease.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Order by", selection: $noteOrderBy) {
                                ForEach(OrderBy.allCases) {
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(noteOrderBy.text, systemImage: "arrow.up.arrow.down")
                        }
                    }

                }
        }
        .tabItem { Label("Notes", systemImage: "note") }
    }
    
    var noteListQuery: Query<Note, [Note]> {
        let sortOrder: SortOrder = noteOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Note>?
        if !noteSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(#Predicate { $0.content.contains(noteSearchText) })
        }
        if noteSortBy == .content {
            return Query(filter: predicate, sort: \.content, order: sortOrder)
        } else {
            return Query(filter: predicate, sort: \.createdAt, order: sortOrder)
        }
    }
    
    var tagList: some View {
        NavigationStack {
            TagListView(allTags: tagListQuery)
                .searchable(text: $tagSearchText, prompt: "Search")
                .textInputAutocapitalization(.never)
                .navigationTitle("Tags")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Order by", selection: $tagOrderBy) {
                                ForEach(OrderBy.allCases) {
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(tagOrderBy.text, systemImage: "arrow.up.arrow.down")
                        }
                    }
                }
        }
        .tabItem { Label("Tags", systemImage: "tag") }
    }
    
    var tagListQuery: Query<Tag, [Tag]> {
        let sortOrder: SortOrder = tagOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Tag>?
        if !tagSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(#Predicate { $0.name.contains(tagSearchText) })
        }
        return Query(filter: predicate, sort: \.name, order: sortOrder)
    }
    
}
