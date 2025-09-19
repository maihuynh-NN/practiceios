// ManageTagsView.swift
import SwiftUI
import SwiftData

struct ManageTagsView: View {
    // The specific to-do item we are tagging, passed from the previous view.
    let todoItem: TodoItem
    
    // Fetch all available tags from the database to display them as options.
    @Query(sort: \Tag.name) private var allTags: [Tag]
    @Environment(\.modelContext) private var modelContext
    
    @State private var newTagName = ""

    var body: some View {
        VStack {
            List {
                Section("Tap to Add/Remove") {
                    ForEach(allTags) { tag in
                        Button(action: {
                            toggle(tag: tag)
                        }) {
                            HStack {
                                Text(tag.name)
                                Spacer()
                                // Show a checkmark if the item already has this tag.
                                if todoItem.tags.contains(where: { $0.id == tag.id }) {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                        .buttonStyle(.plain) // Use plain style to make the whole row tappable.
                    }
                }
            }
            
            // Form to create a new tag available for all items.
            HStack {
                TextField("New Tag Name", text: $newTagName)
                    .textFieldStyle(.roundedBorder)
                Button("Create Tag", action: createTag)
                    .disabled(newTagName.isEmpty)
            }
            .padding()
        }
        .navigationTitle("Manage Tags")
    }
    
    private func createTag() {
        let newTag = Tag(name: newTagName)
        modelContext.insert(newTag)
        newTagName = ""
    }
    
    private func toggle(tag: Tag) {
        // Check if the item already has the tag.
        if let index = todoItem.tags.firstIndex(where: { $0.id == tag.id }) {
            // If it does, remove it.
            todoItem.tags.remove(at: index)
        } else {
            // If it doesn't, add it.
            todoItem.tags.append(tag)
        }
    }
}
