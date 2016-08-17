import RxSwift
import UIKit

enum ImageDownloaderErrorCodes: Int {
    case BadUrl = -100
    case NotImageData = -101
    
    static func domain() -> String {
        return "ImageDownloaderDomain"
    }
}

class ImageDownloader {
    //    TASK IV
    //    1. Create an observable that does the same image downloading as Michałs example did. Use Obervable.create({ observer in ....
    //    2. handle errors, use ImageDownloaderErrorCodes
    //    3. Think how can we dispose the networking code?
    func downloadImageObservable(path:String) -> Observable<UIImage> {
        
    }
}
