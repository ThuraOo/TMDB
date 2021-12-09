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
    
    private var output: HomeViewControllerOutput!
//    private var popularViewModels: [MovieViewModel]!
//    private var upcomingViewModels: [MovieViewModel]!
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
        popularView.addSubview(popularCollectionView)
        popularView.layoutIfNeeded()
        popularCollectionView.initiate(for: .popular, withSize: CGSize(width: popularView.bounds.width, height: popularView.bounds.height), viewModel: [])
    }
    
    private func prepareUpcomingView()
    {
        upcomingViewHeight.constant = 800
        upcomingCollectionView = MovieCollectionView.loadView(for: self)
        upcomingView.addSubview(upcomingCollectionView)
        upcomingView.layoutIfNeeded()
        upcomingCollectionView.initiate(for: .upcoming, withSize: CGSize(width: upcomingView.bounds.width, height: upcomingView.bounds.height), viewModel: [])
    }
    
    private func loadMovieData()
    {
        output.getPopularMovies()
        output.getUpcomingMovies()
    }
    
    private func reloadPopularCollectionView(viewModels: [MovieViewModel])
    {
        popularCollectionView.reloadCollectionWithViewModel(viewModels: viewModels, for: .popular)
    }
    
    private func reloadUpcomingCollectionView(viewModels: [MovieViewModel])
    {
        upcomingCollectionView.reloadCollectionWithViewModel(viewModels: viewModels, for: .upcoming)
    }

}

extension HomeViewController: HomePresenterOutput {
    func updatePopularView(viewModels: [MovieViewModel]) {
        reloadPopularCollectionView(viewModels: viewModels)
    }
    
    func updateUpcomingView(viewModels: [MovieViewModel]) {
        reloadUpcomingCollectionView(viewModels: viewModels)
    }
}

