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
        return Observable.create({ observer in
            // Extract Core Image
            guard let cgImage = image.CGImage else {
                observer.onError(NSError(domain: ImageFilteringErrorCodes.domain(), code: ImageFilteringErrorCodes.CouldNotExtractCGImage.rawValue, userInfo: nil))
                return NopDisposable.instance
            }
            let coreImage = CIImage(CGImage: cgImage)
            
            // Filter
            let filter = CIFilter(name: "CICMYKHalftone")
            filter?.setValue(coreImage, forKey: kCIInputImageKey)
            
            // Handle output
            if let output = filter?.valueForKey(kCIOutputImageKey) as? CIImage {
                let context = CIContext(options: nil)
                let rect = output.extent
                let cgImage = context.createCGImage(output, fromRect:rect)
                let filteredImage = UIImage(CGImage: cgImage)
                observer.onNext(filteredImage)
                observer.onCompleted()
            } else {
                observer.onError(NSError(domain: ImageFilteringErrorCodes.domain(), code: ImageFilteringErrorCodes.CouldNotExtractCGImage.rawValue, userInfo: nil))
            }
            return NopDisposable.instance
        })
    }
}