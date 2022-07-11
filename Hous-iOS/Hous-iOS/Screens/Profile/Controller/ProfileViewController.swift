//
//  ProfileViewController.swift
//  Hous-iOS
//
//  Created by 김지현 on 2022/07/07.
//

import UIKit
import SwiftUI

class ProfileViewController : UIViewController {
  
  let navigationBarView = NavigationBarView(tabType: .rules)
    
  let identifiers = [ProfileInfoCollectionViewCell.identifier, ProfileGraphbCollectionViewCell.identifier, ProfileBedgeCollectionViewCell.identifier]
  
  let cells = [ProfileInfoCollectionViewCell.self, ProfileGraphbCollectionViewCell.self, ProfileBedgeCollectionViewCell.self]
  
  let profileMainCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
    }()
    
  override func viewDidLoad() {
      super.viewDidLoad()
      setUp()
      configureUI()
      setConstraints()
  }
  
  private func setUp(){
      
  }
    
  private func configureUI(){
    [navigationBarView, profileMainCollectionView].forEach {self.view.addSubview($0)}
    profileMainCollectionView.backgroundColor = .yellow
    setDelegate()
    registerCell()
  }
    
  private func setConstraints(){
    profileMainCollectionView.snp.makeConstraints{ make in
        let width = UIScreen.main.bounds.width
        make.top.equalTo(view.safeAreaLayoutGuide).offset(width * (60/375))
        make.bottom.equalToSuperview()
        make.trailing.equalToSuperview()
        make.leading.equalToSuperview()
      }
    navigationBarView.snp.makeConstraints { make in
        let width = UIScreen.main.bounds.width
        make.width.equalTo(width)
        make.height.equalTo(width * (50 / 375))
        make.top.equalTo(view.safeAreaLayoutGuide)
        make.trailing.equalToSuperview()
      }
    }
    
  private func setDelegate(){
      self.profileMainCollectionView.delegate = self
      self.profileMainCollectionView.dataSource = self
  }
    
    
  private func registerCell(){
      self.cells.enumerated().forEach{
          profileMainCollectionView.register($1, forCellWithReuseIdentifier: identifiers[$0])
      }
  }
}
    
extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return identifiers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row{
        case 0:
            guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: identifiers[0], for: indexPath) as? ProfileInfoCollectionViewCell else {return UICollectionViewCell()}
            return cell
        case 1:
            guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: identifiers[1], for: indexPath) as? ProfileGraphbCollectionViewCell else {return UICollectionViewCell()}
            return cell
        
        case 2:
            guard let cell = profileMainCollectionView.dequeueReusableCell(withReuseIdentifier: identifiers[2], for: indexPath) as? ProfileBedgeCollectionViewCell else {return UICollectionViewCell()}
            return cell
        default:
            return UICollectionViewCell()

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        switch indexPath.row{
        case 0:
            return CGSize(width: width, height: 114)
        case 1:
            return CGSize(width: width, height: 354)
        case 2:
            return CGSize(width: width, height: 222)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}

struct VCPreView:PreviewProvider {
    static var previews: some View {
        ProfileViewController().toPreview()
    }
}


    


    
    
    
    
    




