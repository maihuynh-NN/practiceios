//
//  FavoriteAndSearchView.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 20/9/25.
//

import SwiftUI
import SwiftData

struct FavoritesAndSearchView: View {
    @Query private var allTodoItems: [TodoItem]
    @State private var searchText = ""
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        TabView {
            // Tab 1: Search and Filter
            SearchFilterTab(searchText: $searchText, allItems: allTodoItems)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            // Tab 2: Favorites
            FavoritesTab(allItems: allTodoItems)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
        .navigationTitle("Todo Search")
    }
}

#Preview {
    let sampleProject = Project(name: "Sample Project", creationDate: .now)
    
    let item1 = TodoItem(title: "Buy groceries", timeStamp: .now, isCompleted: false)
    let item2 = TodoItem(title: "Finish homework", timeStamp: .now, isCompleted: true)
    let item3 = TodoItem(title: "Call mom", timeStamp: .now, isCompleted: false)
    
    // Set some as favorites for testing
    item1.isFavorite = true
    item3.isFavorite = true
    
    // Assign to project
    sampleProject.items = [item1, item2, item3]
    
    return NavigationStack {
        FavoritesAndSearchView()
    }
    .environmentObject(ThemeManager())
    .modelContainer(for: [Project.self, TodoItem.self, Tag.self], inMemory: true)
}
