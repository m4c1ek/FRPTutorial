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
        guard let url = NSURL(string: path ) else {
            return Observable.error(NSError(domain: ImageDownloaderErrorCodes.domain(), code: ImageDownloaderErrorCodes.BadUrl.rawValue, userInfo: nil))
        }
        
        return Observable.create({ observer in
            let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            let dataTask = defaultSession.dataTaskWithURL(url) { (data, urlResponse, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let data = data, image = UIImage(data: data) else {
                    observer.onError(NSError(domain: ImageDownloaderErrorCodes.domain(), code: ImageDownloaderErrorCodes.NotImageData.rawValue, userInfo: nil))
                    return
                }
                observer.onNext(image)
                observer.onCompleted()
            }
            dataTask.resume()
            
            return AnonymousDisposable {
                dataTask.cancel()
            }
        })
    }
}
