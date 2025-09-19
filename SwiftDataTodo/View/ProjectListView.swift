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
    
    var body: some View {
        NavigationStack {
            
            VStack {
                List {
                    ForEach(projects) {project in
//                            NavigationLink(
//                                destination: TodoListView(project: project)) {
//                                    Text(project.name)
//                                }
                    }
                } // end of List
            } // end of Vstack
            
        } // end of NavigationStack
        .navigationTitle("Projectt")
    }
}
#Preview {
    ProjectListView()
        .modelContainer(for: Project.self, inMemory: true)
}
