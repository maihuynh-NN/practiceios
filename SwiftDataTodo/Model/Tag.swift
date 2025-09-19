//
//  Tag.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 19/9/25.
//

import Foundation
import SwiftData

@Model
final class Tag {
    @Attribute(.unique) var name: String
    
    @Relationship(inverse: \TodoItem.tags) var items: [TodoItem] = []
    
    init (name: String) {
        self.name = name
    }
}
