//
//  HomeViewController.swift
//  Hous-iOS
//
//  Created by 김민재 on 2022/07/09.
//

import UIKit
import SnapKit
import Then


final class HomeViewController: UIViewController {
  
  private enum HomeSection: Int {
    case events
    case rulesTodo
    case profiles
  }
  
  private enum Size {
    static let screenWidth = UIScreen.main.bounds.width
    static let eventCellSize = CGSize(width: Size.screenWidth, height: 88)
    static let profileCellSize = CGSize(width: Size.screenWidth / 3 - 22, height: Size.screenWidth / 3 - 22)
    static let titleCellSize = CGSize(width: Size.screenWidth, height: 37)
  }
  
  //MARK: Properties
  private var rules: [RulesDataModel]?
  private var todos: [TodoDataModel]?
  
  //MARK: UI Compononents
  private let titleLabel = UILabel().then {
    $0.text = "Hous-"
    $0.font = .font(.montserratSemiBold, ofSize: 30)
    $0.textColor = .housBlack
    $0.textAlignment = .left
  }
  
  private let homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    $0.collectionViewLayout = layout
    $0.showsVerticalScrollIndicator = false
    
  }
  
  //MARK: LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    render()
    setCollectionView()
    getRulesAndTodoList()
  }
  
  //MARK: Custom Methods
  private func configUI() {
    self.view.backgroundColor = .white
  }
  
  private func getRulesAndTodoList() {
    rules = RulesDataModel.sampleData
    todos = TodoDataModel.sampleData
  }
  
  private func setCollectionView() {
    homeCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.className)
    
    homeCollectionView.register(cell: ComingEventsCollectionViewCell.self)
    homeCollectionView.register(cell: RulesTodoCollectionViewCell.self)
    homeCollectionView.register(cell: ProfileCollectionViewCell.self)
    
    homeCollectionView.delegate = self
    homeCollectionView.dataSource = self
  }
  
  private func render() {
    view.addSubViews([titleLabel, homeCollectionView])
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(19)
      $0.leading.equalToSuperview().offset(24)
      $0.trailing.equalToSuperview()
    }
    
    homeCollectionView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(24).multipliedBy(0.9)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
  
}


//MARK: Delegate & Datasource
extension HomeViewController: UICollectionViewDelegate {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if section == HomeSection.events.rawValue || section == HomeSection.profiles.rawValue {
      return CGSize(width: view.frame.size.width, height: 24)
    }
    
    return CGSize.zero
    
  }
}

extension HomeViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    switch section {
    case 0..<2:
      return 1
    case 2:
      return ProfileDataModel.sampleData.count + 1
    default:
      return 0
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch indexPath.section {
    case 0:
      guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: ComingEventsCollectionViewCell.className, for: indexPath) as? ComingEventsCollectionViewCell else { return UICollectionViewCell() }
      
      cell.delegate = self
      
      return cell
    case HomeSection.rulesTodo.rawValue:
      guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: RulesTodoCollectionViewCell.className, for: indexPath) as? RulesTodoCollectionViewCell,
            let rules = rules,
            let todos = todos
      else { return UICollectionViewCell() }
      
      if todos.count == 0 {
        cell.emptyTodoLabel.isHidden = false
      }
      if rules.count == 0 {
        cell.emptyRuleLabel.isHidden = false
      }
      
      cell.setRulesData(rules)
      cell.setTodosData(todos)
      
      return cell
    case HomeSection.profiles.rawValue:
      guard let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.className, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell() }
      
      if indexPath.row == ProfileDataModel.sampleData.count {
        cell.profileStack.isHidden = true
        cell.codeViewStack.isHidden = false
        
        return cell
      }
      
      cell.setProfileData(ProfileDataModel.sampleData[indexPath.row])
      
      return cell
    default:
      return UICollectionViewCell()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      guard let header = homeCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.className, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
      
      switch indexPath.section {
      case HomeSection.events.rawValue:
        header.setSubTitleLabel(data: "Coming up-")
      case HomeSection.profiles.rawValue:
        header.setSubTitleLabel(data: "Homie Profile-")
      default:
        return UICollectionReusableView()
      }
      
      return header
    }
    return UICollectionReusableView()
  }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    // CollectionView dynamic height
    switch indexPath.section {
    case HomeSection.events.rawValue:
      return Size.eventCellSize
    case HomeSection.rulesTodo.rawValue:
      return CGSize(width: Size.screenWidth, height: 200)
    case HomeSection.profiles.rawValue:
      return Size.profileCellSize
    default:
      return CGSize()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    switch section {
    case HomeSection.events.rawValue:
      return UIEdgeInsets(top: 12, left: 0, bottom: 24, right: 0)
    case HomeSection.rulesTodo.rawValue:
      return UIEdgeInsets(top: 3, left: 0, bottom: 24, right: 0)
    case HomeSection.profiles.rawValue:
      return UIEdgeInsets(top: 12, left: 24, bottom: 0, right: 24)
    default:
      return UIEdgeInsets()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
    switch section {
    case HomeSection.profiles.rawValue:
      return 12
    default:
      return 0
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    
    switch section {
    case HomeSection.profiles.rawValue:
      return 9
    default:
      return 0
    }
    
  }
}


extension HomeViewController: ComingEventsCollectionViewCellDelegate {
  
  func showPopup(_ row: Int) {
    let popUp = PopUpViewController()
    popUp.modalTransitionStyle = .crossDissolve
    popUp.modalPresentationStyle = .overFullScreen
    present(popUp, animated: true)
  }
}


