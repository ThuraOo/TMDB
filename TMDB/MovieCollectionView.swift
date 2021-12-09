//
//  MovieCollectionView.swift
//  TMDB
//
//  Created by ThuraOo on 09/12/2021.
//

import UIKit

enum MovieSectionType {
    case popular, upcoming
}

class MovieCollectionView: UIView {
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var cellWidth : CGFloat!
    private var cellHeight : CGFloat!
    
    func initiate(for type : MovieSectionType, withSize size : CGSize) {
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.layoutIfNeeded()
        prepareCollectionView()
        switch type {
            case .popular : configForPopular()
            case .upcoming : configForUpcoming()
        }
    }
    
    private func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func configForPopular() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        collectionView.collectionViewLayout = layout
        cellHeight = 200
        cellWidth = cellHeight * 1.61 //golden ratio
        sectionLabel.text = "Popular Now"
    }
    
    private func configForUpcoming() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        collectionView.collectionViewLayout = layout
        cellWidth = (collectionView.bounds.width - 60) / 2
        cellHeight = cellWidth * 1.61 //golden ratio
        sectionLabel.text = "Upcoming Movies"
    }
}

//static functions for ease of use
extension MovieCollectionView {
    
    static func loadView(for vc : UIViewController) -> MovieCollectionView {
        let nib = UINib(nibName: "MovieCollectionView", bundle: Bundle(for: type(of: vc)))
        let view = nib.instantiate(withOwner: nil, options: nil).first as! MovieCollectionView
        return view
    }
}

//UICollectionView functions
extension MovieCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
