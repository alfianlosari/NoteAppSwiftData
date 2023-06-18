//
//  Tag.swift
//  NoteSwiftData
//
//  Created by Alfian Losari on 07/06/23.
//

import Foundation
import SwiftData

@Model
class Tag {
    var id: String?
    var name: String = ""
    
    @Relationship var notes: [Note]?
    @Attribute(.transient) var isChecked = false
    
    init(id: String, name: String, notes: [Note]) {
        self.id = id
        self.name = name
        self.notes = notes
    }
}
