//
//  ProjectListView.swift
//  SwiftDataTodo
//
//  Created by Mai Huynh Ngoc Nhat on 19/9/25.
//
import SwiftUI
import SwiftData

struct ProjectListView: View {
    @Environment(\.modelContext) private var modelContext // crud operations
    // fetch data, auto update view if data changes
    @Query(
        sort: \Project.creationDate,
        order: .reverse
    ) private var projects: [Project]
    
    @State private var newProjectName = ""
    
    private func deleteProjects(offsets: IndexSet) {
        for index in offsets {
            let projectToDelete = projects[index]
            modelContext.delete(projectToDelete)
        }
    }
    
    private func addProject() {
        let newProject = Project(
            name: newProjectName,
            creationDate: .now
        )
        modelContext.insert(newProject)
        newProjectName = ""
    }
    
    var body: some View {
        NavigationStack {
            
            VStack {
                List {
                    ForEach(projects) {project in
                            NavigationLink(
                                destination: TodoListView(project: project)) {
                                    Text(project.name)
                                }
                    }
                    .onDelete(perform: deleteProjects)
                } // end of List
                
                HStack {
                    TextField("Add a new project", text: $newProjectName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("add ", action: addProject)
                        .disabled(newProjectName.isEmpty)
                }
            } // end of Vstack
            .navigationTitle("Projectt")

        } // end of NavigationStack
    }
}



#Preview {

    
    
    ProjectListView()
        .modelContainer(for: Project.self, inMemory: true)
}
