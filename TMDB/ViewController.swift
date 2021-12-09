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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPopularView()
        addUpcomingView()
        // Do any additional setup after loading the view.
    }
    
    private func addPopularView()
    {
        let nib = UINib(nibName: "MovieCollectionView", bundle: Bundle(for: type(of: self)))
        let view = nib.instantiate(withOwner: nil, options: nil).first as! MovieCollectionView
        popularView.addSubview(view)
        view.frame = CGRect(x: 0, y: 0, width: popularView.frame.width, height: popularView.frame.height)
    }
    
    private func addUpcomingView()
    {
        let nib = UINib(nibName: "MovieCollectionView", bundle: Bundle(for: type(of: self)))
        let view = nib.instantiate(withOwner: nil, options: nil).first as! MovieCollectionView
        upcomingView.addSubview(view)
        view.frame = CGRect(x: 0, y: 0, width: upcomingView.frame.width, height: upcomingView.frame.height)
    }


}

