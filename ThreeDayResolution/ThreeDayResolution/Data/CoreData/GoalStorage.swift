//
//  GoalStorage.swift
//  ThreeDayResolution
//
//  Created by 유정주 on 2023/06/30.
//

import Foundation
import CoreData

struct GoalStorage {
    typealias EntityType = GoalEntity
    private let entityName = "GoalEntity"
    
    func fetch() throws -> [Goal] {
        let context = CoreDataStorage.shared.context
        
        let request = EntityType.fetchRequest()
        
        let contentEntities = try context.fetch(request)
        return contentEntities.compactMap { toModel($0) }
    }
    
    func save(goal: Goal) throws {
        let context = CoreDataStorage.shared.context
        
        let entity = toEntity(goal, context: context)
        
        try context.save()
    }
    
    func delete(goal: Goal) throws {
        let context = CoreDataStorage.shared.context
        
        let filter = filteredRequestWith(goal: goal.goal, createdAt: goal.createdAt)
        let deleteItems = try context.fetch(filter).compactMap { $0 as? EntityType }
        
        deleteItems.forEach { context.delete($0) }
        
        try context.save()
    }

    private func filteredRequestWith(goal: String, createdAt: Date) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "goal == %@ && createdAt == %@", "\(goal)", "\(createdAt)")
        return fetchRequest
    }

}

extension GoalStorage {
    private func toEntity(_ goal: Goal, context: NSManagedObjectContext) -> EntityType {
        let item = EntityType(context: context)
        
        item.goal = goal.goal
        item.count = Int32(goal.count)
        item.lastCompletedDate = goal.lastCompletedDate
        item.createdAt = goal.createdAt
        item.isBookmarked = goal.isBookmarked
        
        return item
    }
    
    private func toModel(_ entity: EntityType) -> Goal? {
        guard let goal = entity.goal,
              let createdAt = entity.createdAt,
              let lastCompletedDate = entity.lastCompletedDate else {
            return nil
        }
        
        return .init(goal: goal,
                     count: Int(entity.count),
                     createdAt: createdAt,
                     lastCompletedDate: lastCompletedDate,
                     isBookmarked: entity.isBookmarked)
    }
}
