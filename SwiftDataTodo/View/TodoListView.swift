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
                    HStack {
                        Button(action: {
                            item.isCompleted.toggle()
                        }) {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        }
                        
                        Text(item.title)
                    }
                }
                .onDelete(perform: deleteItems)
                // .onDelete passes IdexSet, tells which indices in project.items in the list the user swiped-to-delete.
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

