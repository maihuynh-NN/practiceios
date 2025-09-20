//
//  TodoListView.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 19/9/25.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    let project: Project
    
    @Environment(\.modelContext) private var modelContext
    @State private var newTodoTitle = ""
    // 1. theme
    @EnvironmentObject var themeManager: ThemeManager
    
    private func addTodoItem() {
        // 1. define
        let newItem = TodoItem(
            title: newTodoTitle,
            timeStamp: .now,
            isCompleted: false
        )
        
        // 2. append newItem to "items" rlationship in Project
        project.items.append(newItem)
        newTodoTitle = ""
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            let itemDelete = project.items[index]
            modelContext.delete(itemDelete)
        }
    }
    
    var body: some View {
     
        VStack {
            // 1. delete functonality
            List {
                ForEach(project.items) { item in
                    NavigationLink(destination: ManageTagsView(todoItem: item)
                        .environmentObject(themeManager)) {
                            
                        HStack {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    // Make the checkmark tappable directly in the list.
                                    item.isCompleted.toggle()
                                }
                            
                            // 2. Add favorite button
                              Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                                  .foregroundColor(item.isFavorite ? .red : .gray)
                                  .onTapGesture {
                                      item.isFavorite.toggle()
                                  }
                            
                            VStack(alignment: .leading) {
                                Text(item.title)
                                
                                // Display the tags for this item if any exist.
                                if !item.tags.isEmpty {
                                    HStack {
                                        // Sort the tags alphabetically for a consistent order.
                                        ForEach(item.tags.sorted(by: { $0.name < $1.name })) { tag in
                                            Text(tag.name)
                                                .font(.caption)
                                                .padding(4)
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(5)
                                        }
                                    }
                                }
                            }
                        }
                            
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            // 2. add to new list
            HStack {
                TextField("Add New to do ites", text: $newTodoTitle)
                    .textFieldStyle(.roundedBorder)
                Button("Add", action: addTodoItem)
                    .disabled(newTodoTitle.isEmpty)
            }
            .padding()
        }
        .navigationTitle(project.name)
    }
    
   
}

#Preview {
    // Create a sample project with today's date
    let sampleProject = Project(name: "Preview Project", creationDate: .now)
    
    // Add some mock to-do items
    let item1 = TodoItem(title: "Buy groceries", timeStamp: .now, isCompleted: false)
    let item2 = TodoItem(title: "Finish SwiftData demo", timeStamp: .now, isCompleted: true)
    
    sampleProject.items.append(contentsOf: [item1, item2])
    
    return NavigationStack {
        TodoListView(project: sampleProject)
    }
    .modelContainer(for: [Project.self, TodoItem.self], inMemory: true)
}

