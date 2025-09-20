//
//  ThemeManager.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 20/9/25.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var isDarkMode: Bool = false
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
}

