//
//  ProfileGraphCollectionViewCell.swift
//  Hous-iOS
//
//  Created by 이의진 on 2022/07/11.
//


import UIKit
import SwiftUI

class ProfileGraphbCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "ProfileGraphCollectionViewCell"
    
    
    //MARK: - Properties
    
    let tempLabel = UILabel().then{
        $0.text = "Temp"
    }
    
    //MARK: - Override Methods
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func configureUI(){
        self.backgroundColor = .blue
        [tempLabel].forEach {self.addSubview($0)}
    }
    
    private func setConstraints(){
        tempLabel.snp.makeConstraints{make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.centerY.equalToSuperview()
        }
    }
    
    
}

struct VCPreView3:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}
