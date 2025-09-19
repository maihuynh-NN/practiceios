//
//  TodoItem.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 19/9/25.
//
import Foundation
import SwiftData

@Model
final class TodoItem {
    var title: String
    var timeStamp: Date
    var isCompleted: Bool
    
    init(title: String, timeStamp: Date, isCompleted: Bool) {
        self.title = title
        self.timeStamp = timeStamp
        self.isCompleted = isCompleted
    }
    
    var project: Project?    // one to many
    var tags: [Tag] = []

}
