//
//  FavoriteTabs.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 20/9/25.
//
import SwiftUI

struct FavoritesTab: View {
    let allItems: [TodoItem]
    
    var favoriteItems: [TodoItem] {
        allItems.filter { $0.isFavorite }
    }
    
    var body: some View {
        VStack {
            if favoriteItems.isEmpty {
                Text("No favorite items yet")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                List(favoriteItems) { item in
                    HStack {
                        Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(item.isCompleted ? .green : .gray)
                        
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                        
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
}
