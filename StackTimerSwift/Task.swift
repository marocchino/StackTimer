import Cocoa
import CoreData

@objc(Task)
class Task: NSManagedObject {
    @NSManaged var title : NSString
    @NSManaged var finished : Bool
    @NSManaged var startedAt : NSDate
    @NSManaged var finishedAt : NSDate
    
    func start(title : NSString) {
        self.title = title
        self.finished = false
        self.startedAt = NSDate.date()
    }
    
    func finish() {
        self.finished = true
        self.finishedAt = NSDate.date()
    }
}