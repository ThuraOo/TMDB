//
//  ViewController.swift
//  TMDB
//
//  Created by ThuraOo on 09/12/2021.
//

import UIKit

protocol HomeViewControllerOutput {
    func getPopularMovies()
    func getUpcomingMovies()
}

class HomeViewController: UIViewController {

    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var popularViewHeight: NSLayoutConstraint!
    @IBOutlet weak var upcomingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var offlineLabel: UILabel!
    
    private var output: HomeViewControllerOutput!
    private var popularCollectionView: MovieCollectionView!
    private var upcomingCollectionView: MovieCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVIP()
        preparePopularView()
        prepareUpcomingView()
        loadMovieData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reloadAPIData(_ sender: UIBarButtonItem) {
        loadMovieData()
        print("api data reloaded")
    }
    
    private func configureVIP() { //VIP circle
        let interacter = HomeInteractor()
        let presenter = HomePresenter()
        output = interacter
        interacter.output = presenter
        presenter.output = self
    }
    
    private func preparePopularView()
    {
        popularViewHeight.constant = 250
        popularCollectionView = MovieCollectionView.loadView(for: self)
        popularCollectionView.delegate = self
        popularView.addSubview(popularCollectionView)
        popularView.layoutIfNeeded()
        popularCollectionView.initiate(for: .popular, withSize: CGSize(width: popularView.bounds.width, height: popularView.bounds.height), viewModel: [])
    }
    
    private func prepareUpcomingView()
    {
        upcomingViewHeight.constant = 800
        upcomingCollectionView = MovieCollectionView.loadView(for: self)
        upcomingCollectionView.delegate = self
        upcomingView.addSubview(upcomingCollectionView)
        upcomingView.layoutIfNeeded()
        upcomingCollectionView.initiate(for: .upcoming, withSize: CGSize(width: upcomingView.bounds.width, height: upcomingView.bounds.height), viewModel: [])
    }
    
    private func loadMovieData()
    {
        output.getPopularMovies()
        output.getUpcomingMovies()
    }
    
    private func setProperUpcomingSectionHeight(dataCount: Int) {
        
        let cellWidth : CGFloat = (self.view.bounds.width - 60) / 2
        let cellHeight : CGFloat = (cellWidth * 1.61) + 80 //golden ratio
        var finalHeight : CGFloat = 0
        if (dataCount % 2 == 0) {
            finalHeight = (cellHeight + 20) * CGFloat(dataCount / 2)
        } else {
            finalHeight = (cellHeight + 20) * CGFloat(dataCount / 2) + cellHeight + 20
        }
        upcomingViewHeight.constant = finalHeight
        upcomingView.layoutIfNeeded()
    }
}

extension HomeViewController: MovieCollectionViewProtocol {
    func showMovieDetailView(id: Int) {
        let storyboard = UIStoryboard.init(name: StoryboardIDs.movieDetailView, bundle: Bundle.main)
        let mdv = storyboard.instantiateViewController(withIdentifier: StoryboardIDs.movieDetailView) as! MovieDetailView
        mdv.title = "MovieDetailView"
        mdv.id = id
        self.navigationController?.pushViewController(mdv, animated: true)
        print("id is \(id)")
    }
}

extension HomeViewController: HomePresenterOutput {
    func toggleOfflineLabel(show: Bool) {
        offlineLabel.isHidden = !show
    }
    
    func updatePopularView(viewModels: [MovieViewModel]) {
        popularCollectionView.reloadCollectionWithViewModel(viewModels: viewModels, for: .popular)
    }
    
    func updateUpcomingView(viewModels: [MovieViewModel]) {
        upcomingCollectionView.reloadCollectionWithViewModel(viewModels: viewModels, for: .upcoming)
        setProperUpcomingSectionHeight(dataCount: viewModels.count)
    }
}

