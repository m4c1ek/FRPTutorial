import RxSwift
import CoreImage
import UIKit

protocol ImageFilter:class {
    func filterImageObservable(image:UIImage) -> Observable<UIImage>
}

enum ImageFilteringErrorCodes: Int {
    case CouldNotExtractCGImage = -200
    case FilteringImageFailed = -201
    
    static func domain() -> String {
        return "CatImageFilteringDomain"
    }
}

class CMYKFilter : ImageFilter {
    //    1. Create an observable that does the same filtering as Michałs example did
    //    2. handle errors, use ImageFilteringErrorCodes
    //    3. Think how can we dispose the filtering?
    func filterImageObservable(image: UIImage) -> Observable<UIImage> {
        
    }
}