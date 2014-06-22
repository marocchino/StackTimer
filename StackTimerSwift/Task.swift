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
    func interval() -> NSString {
        var elapsedTime : NSTimeInterval = -self.startedAt.timeIntervalSinceNow
        return NSString(format: "%02li:%02li:%02li",
            lround(floor(elapsedTime / 3600)) % 100,
            lround(floor(elapsedTime / 60)) % 60,
            lround(floor(elapsedTime)) % 60);
    }
}