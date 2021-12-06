//
//  CustomPageCell.swift
//  CustomTabbar
//
//  Created by baegteun on 2021/12/06.
//

import UIKit
import Then
import SnapKit

final class CustomPageCell: UICollectionViewCell{
    // MARK: - Properties
    static var identifier = "customPageCell"
    
    private let label = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 30)
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    func setLabelText(with text: String){
        self.label.text = text
    }
}

// MARK: - UI
extension CustomPageCell{
    private func setUI(){
        [label].forEach{ addSubview($0) }
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

