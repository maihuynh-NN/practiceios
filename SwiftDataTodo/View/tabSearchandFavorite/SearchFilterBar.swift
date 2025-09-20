//
//  SearchFilterBar.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 20/9/25.
//
import SwiftUI

struct SearchFilterTab: View {
    @Binding var searchText: String
    let allItems: [TodoItem]
    
    var filteredItems: [TodoItem] {
        if searchText.isEmpty {
            return allItems
        } else {
            return allItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            // Search bar
            TextField("Search todos...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            // Results list
            List(filteredItems) { item in
                HStack {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isCompleted ? .green : .gray)
                    
                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(item.isFavorite ? .red : .gray)
                    
                    VStack(alignment: .leading) {
                        Text(item.title)
                        Text("Project: \(item.project?.name ?? "No Project")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
