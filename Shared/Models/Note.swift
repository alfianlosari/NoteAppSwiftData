//
//  Note.swift
//  NoteSwiftData
//
//  Created by Alfian Losari on 07/06/23.
//

import Foundation
import SwiftData

@Model
class Note {
    var id: String?
    var content: String = ""
    var createdAt: Date = Date()
    
    @Relationship(inverse: \Tag.notes) var tags: [Tag]?
    
    init(id: String, content: String, createdAt: Date, tags: [Tag]) {
        self.id = id
        self.content = content
        self.createdAt = createdAt
        self.tags = tags
    }
}
