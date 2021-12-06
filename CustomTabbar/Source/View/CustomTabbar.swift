//
//  CustomTabbar.swift
//  CustomTabbar
//
//  Created by baegteun on 2021/12/06.
//

import UIKit
import Then
import SnapKit

protocol CustomTabbarDelegate: class{
    func customTabbar(scrollTo index: Int)
}

final class CustomTabbar: UIView{
    // MARK: - Properties
    private let bound = UIScreen.main.bounds
    
    weak var delegate: CustomTabbarDelegate?
    
    private let customTabbarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.showsHorizontalScrollIndicator = false
        collection.register(CustomTabbarCell.self, forCellWithReuseIdentifier: CustomTabbarCell.identifier)
        collection.isScrollEnabled = false
        return collection
    }()
    
    var indicatorWidthConstraint: NSLayoutConstraint!
    var indicatorLeadingConstraint: NSLayoutConstraint!
    
    private let indicatorView = UIView().then {
        $0.backgroundColor = .black
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUI
    func setUI(){
        addView()
        setLayout()
        customTabbarCollectionView.delegate = self
        customTabbarCollectionView.dataSource = self
        addView()
        setLayout()
    }
    
    func selectItem(at indexpath: IndexPath, animated: Bool, scrollPosition: UICollectionView.ScrollPosition){
        customTabbarCollectionView.selectItem(at: indexpath, animated: animated, scrollPosition: scrollPosition)
    }
    
}

// MARK: - UI
private extension CustomTabbar{
    func addView(){
        [customTabbarCollectionView, indicatorView].forEach{ addSubview($0) }
    }
    func setLayout(){
        customTabbarCollectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(55)
        }
        indicatorView.snp.makeConstraints {
            $0.width.equalTo(bound.width/4)
            $0.height.equalTo(5)
            $0.bottom.equalToSuperview()
        }
        
        indicatorWidthConstraint =  indicatorView.widthAnchor.constraint(equalToConstant: bound.width/4)
        indicatorWidthConstraint.isActive = true
        indicatorWidthConstraint.constant = bound.width/4
        indicatorLeadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        indicatorLeadingConstraint.isActive = true
        
        let index = IndexPath(row: 0, section: 0)
        selectItem(at: index, animated: false, scrollPosition: [])
    }
}

// MARK: - Extensions
extension CustomTabbar: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTabbarCell.identifier, for: indexPath) as! CustomTabbarCell
        cell.setNameText(with: "Tab \(indexPath.row)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.frame.width / 4, height: 55)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.customTabbar(scrollTo: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomTabbarCell else { return }
        cell.setNameColor(with: .lightGray)
    }
}


extension CustomTabbar: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
