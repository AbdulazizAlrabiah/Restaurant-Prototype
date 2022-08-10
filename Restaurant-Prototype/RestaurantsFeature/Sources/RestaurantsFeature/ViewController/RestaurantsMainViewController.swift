
import UIKit

public class RestaurantsMainViewController: UIViewController {
    
    let viewModel: RestaurantsMainViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RestaurantsTableViewCell.self, forCellReuseIdentifier: RestaurantsTableViewCell.identifier)
        return tableView
    }()

    public init(viewModel: RestaurantsMainViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        
        activityIndicatorView.startAnimating()
        tableView.backgroundView = activityIndicatorView
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        
        getRestaurants()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func getRestaurants() {
        
        Task { [weak self] in
            await viewModel.getRestaurants()
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.backgroundView = nil
            }
        }
    }
}

extension RestaurantsMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCell = tableView.cellForRow(at: indexPath) as? RestaurantsTableViewCell
        
        guard let selectedCell = selectedCell else {
            print("Couldn't find or cast table view cell to our custom type!")
            return
        }
        
        let detailVC = DependencyProvider.getDetailScreen(restaurant: viewModel.restaurants[indexPath.row],
                                                          restaurantImage: selectedCell.loadedImage)
        
        self.present(detailVC, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.restaurants.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantsTableViewCell.identifier,
                                                 for: indexPath) as? RestaurantsTableViewCell ?? RestaurantsTableViewCell()
        
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
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: Modify to custom size depending on screen size
        return 80
    }
}
