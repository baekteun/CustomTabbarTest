//
//  MainVC.swift
//  CustomTabbar
//
//  Created by baegteun on 2021/12/06.
//

import UIKit
import Then
import SnapKit

final class MainVC: UIViewController{
    // MARK: - Properties
    private let pageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        collection.register(CustomPageCell.self, forCellWithReuseIdentifier: CustomPageCell.identifier)
        collection.isScrollEnabled = false
        return collection
    }()
    
    
    private let customTabbar = CustomTabbar()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
        customTabbar.delegate = self
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        
    }
    
    
}

// MARK: - UI
private extension MainVC{
    func addView(){
        [customTabbar, pageCollectionView].forEach{ view.addSubview($0) }
    }
    func setLayout(){
        customTabbar.snp.makeConstraints {
            $0.trailing.leading.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
        
        pageCollectionView.snp.makeConstraints {
            $0.top.equalTo(customTabbar.snp.bottom)
            $0.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - CustomTabbarDelegate
extension MainVC: CustomTabbarDelegate{
    func customTabbar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDatasource
extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomPageCell.identifier, for: indexPath) as? CustomPageCell else { return .init() }
        cell.setLabelText(with: "test \(indexPath.row)")
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customTabbar.indicatorLeadingConstraint.constant = scrollView.contentOffset.x / 4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let index = IndexPath(row: itemAt, section: 0)
        customTabbar.selectItem(at: index, animated: true, scrollPosition: [])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: pageCollectionView.frame.width, height: pageCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
