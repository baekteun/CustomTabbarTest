//
//  CustomTabbarCell.swift
//  CustomTabbar
//
//  Created by baegteun on 2021/12/06.
//

import UIKit
import SnapKit
import Then

final class CustomTabbarCell: UICollectionViewCell{
    // MARK: - Properties
    private let tabbarNameLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .lightGray
    }
    
    static let identifier = "customTabbarCell"
    
    override var isSelected: Bool{
        didSet{
            self.tabbarNameLabel.textColor = isSelected ? .black : .lightGray
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    private func setUI(){
        [tabbarNameLabel].forEach{addSubview($0)}
        tabbarNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Method
    func setNameColor(with color: UIColor){
        self.tabbarNameLabel.textColor = color
    }
    
    func setNameText(with text: String){
        self.tabbarNameLabel.text = text
    }
}
