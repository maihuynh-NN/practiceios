//
//  Item.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 19/9/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
