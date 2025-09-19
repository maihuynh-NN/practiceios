//
//  Project.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 19/9/25.
//
import SwiftData
import Foundation

@Model
final class Project {
    var name: String
    var creationDate: Date
    
    @Relationship(
        deleteRule: .cascade,
        inverse: \TodoItem.project
    ) var items: [TodoItem] = []
    
    init(name: String, creationDate: Date) {
        self.name = name
        self.creationDate = creationDate
    }
}

