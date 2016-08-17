import UIKit
import RxSwift

protocol ImageProvider {
    func fetchImageObservable(withWidth width:Int, height:Int) -> Observable<UIImage>
}

class CatProvider: ImageProvider {
    private var downloader = ImageDownloader()
    
    func fetchImageObservable(withWidth width: Int, height: Int) -> Observable<UIImage> {
        return downloader.downloadImageObservable("http://lorempixel.com/\(width)/\(height)/cats/")
    }
}

class CatViewController: UIViewController {
    
    @IBOutlet weak var catImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        TASK I
        //        1. use the fetch image observable from CatProvider to display the image of the cat
        //        2. remember to display the result on the main thread
        
        //        TASK II
        //        3. show and hide an activity indicator when appropriate
        //        UIApplication.sharedApplication().networkActivityIndicatorVisible
        
        //        TASK III
        //        4. cancel the network request when the CatViewController is dismissed
        
        //        TASK IV
        //        5. apply the image filter in the same rx chain
        
        //        TASK V
        //        6. use the network request observable to fetch the cat image only when there is network connectivity
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        CatProvider()
            .fetchImageObservable(withWidth: Int(self.view.frame.width), height: Int(self.view.frame.height))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (image) in
                self?.catImageView.image = image
                }, onError: { (error) in
                    print(error)
                }, onCompleted: {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }, onDisposed: {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
            .addDisposableTo(disposeBag)
    }
}