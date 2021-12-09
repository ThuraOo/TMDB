//
//  ViewController.swift
//  TMDB
//
//  Created by ThuraOo on 09/12/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var popularViewHeight: NSLayoutConstraint!
    @IBOutlet weak var upcomingViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preparePopularView()
        prepareUpcomingView()
        // Do any additional setup after loading the view.
    }
    
    private func preparePopularView()
    {
        popularViewHeight.constant = 250
        let view = MovieCollectionView.loadView(for: self)
        popularView.addSubview(view)
        popularView.layoutIfNeeded()
        view.initiate(for: .popular, withSize: CGSize(width: popularView.bounds.width, height: popularView.bounds.height))
    }
    
    private func prepareUpcomingView()
    {
        upcomingViewHeight.constant = 800
        let view = MovieCollectionView.loadView(for: self)
        upcomingView.addSubview(view)
        upcomingView.layoutIfNeeded()
        view.initiate(for: .upcoming, withSize: CGSize(width: upcomingView.bounds.width, height: upcomingView.bounds.height))
    }

}

