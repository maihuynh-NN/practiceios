//
//  SwiftDataTodoApp.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 19/9/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTodoApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Project.self,
            TodoItem.self,
            Tag.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ProjectListView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        }
        .modelContainer(sharedModelContainer)
    }
}

#Preview {
    ProjectListView()
        .modelContainer(for: [Project.self, TodoItem.self, Tag.self], inMemory: true)

}
