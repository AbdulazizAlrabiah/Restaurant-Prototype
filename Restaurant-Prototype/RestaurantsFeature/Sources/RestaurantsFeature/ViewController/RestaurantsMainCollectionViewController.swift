//
//  RestaurantsMainCollectionViewController.swift
//  
//
//  Created by Abdulaziz on 09/08/2022.
//

import UIKit

public class RestaurantsMainCollectionViewController: UICollectionViewController {
    
    let viewModel: RestaurantsMainViewModel
    
    lazy var dataSource = makeDataSource()
    
    var cellRegistration: UICollectionView.CellRegistration<RestaurantsCollectionViewCell, Restaurant>
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Restaurant>
    
    enum Section: Int, Hashable {
      case restaurant
    }

    public init(viewModel: RestaurantsMainViewModel) {
        
        self.viewModel = viewModel
        
        cellRegistration = UICollectionView.CellRegistration<RestaurantsCollectionViewCell, Restaurant> { cell, indexPath, restaurant in
            
            cell.showOrHideActivityIndicator(show: true, cell: cell)
            
            cell.customText = viewModel.restaurants[indexPath.row].name
            let imageUrl = viewModel.restaurants[indexPath.row].image
            
            Task {
                cell.loadedImage = nil

                let imageData = await viewModel.getImageData(url: imageUrl)

                guard let imageData = imageData else {
                    return
                }

                DispatchQueue.main.async {
                    cell.showOrHideActivityIndicator(show: false, cell: cell)
                    cell.loadedImage = UIImage(data: imageData)
                }
            }
        }
        
        super.init(collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: {
            (_, _) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(80))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(80))
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            
            return section
        }))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemGray6
        getRestaurants()
    }
    
    func makeDataSource() -> DataSource {
        
        return DataSource(collectionView: collectionView) { collectionView, indexPath, item -> RestaurantsCollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell ( using: self.cellRegistration, for: indexPath, item: item)
        }
    }
    
    func applyInitialSnapshots() {
        
        var categorySnapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        
        categorySnapshot.appendSections([.restaurant])
        
        categorySnapshot.appendItems(viewModel.restaurants, toSection: .restaurant)
        
        dataSource.apply(categorySnapshot, animatingDifferences: false)
    }
    
    private func getRestaurants() {
        
        Task { [weak self] in
            await viewModel.getRestaurants()
            
            DispatchQueue.main.async {
                self?.applyInitialSnapshots()
            }
        }
    }
    
    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as? RestaurantsCollectionViewCell
        
        guard let selectedCell = selectedCell else {
            print("Couldn't find or cast table view cell to our custom type!")
            return
        }
        
        let detailVC = DependencyProvider.getDetailScreen(restaurant: viewModel.restaurants[indexPath.row],
                                                          restaurantImage: selectedCell.loadedImage)
        
        self.present(detailVC, animated: true) {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
