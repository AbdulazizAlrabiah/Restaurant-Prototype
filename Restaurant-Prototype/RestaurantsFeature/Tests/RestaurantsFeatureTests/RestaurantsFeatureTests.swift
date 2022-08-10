import XCTest
@testable import RestaurantsFeature

final class RestaurantsFeatureTests: XCTestCase {
    
    // Should resize proportionally
    func testResizeImage() {
        
        let viewModel = DependencyProvider.getDetailScreenVM
        
        let targetSize = CGSize(width: 65, height: 100)
        
        let image = UIImage(named: "kudu", in: .module, with: nil)
        
        let resizedImage = viewModel.resizeImageIfLargerThan(image: image,
                                                             largerThan: targetSize)
        
        XCTAssertEqual(resizedImage?.size, targetSize)
    }
    
    // Shouldn't resize the image since the target size is bigger than the image's size
    func testNotResizingImage() {
        
        let viewModel = DependencyProvider.getDetailScreenVM
        
        let targetSize = CGSize(width: 500, height: 500)
        
        let image = UIImage(named: "kudu", in: .module, with: nil)
        
        let originalImageSize = image?.size
        
        let resizedImage = viewModel.resizeImageIfLargerThan(image: image,
                                                             largerThan: targetSize)
        
        XCTAssertEqual(resizedImage?.size, originalImageSize)
    }
}
