# 🏡 Hous-iOS
![KakaoTalk_Photo_2022-07-22-07-03-05](https://user-images.githubusercontent.com/60493070/180322745-92fdc3f3-9300-4c3a-9f93-211354ee5725.png)

<br/>

# 🏠 About Hous- 🧐

### **_우리의 House를 위한 How is - 💡_**

<br/>

SOPT 30th APPJAM

- 프로젝트 기간: 2021.06.18 ~
- [👉 Code Convention](https://sugared-lemming-812.notion.site/Code-Convention-34a4c6aa434a468f82b6ee0a763430b4)
- [👉 Git Convention](https://sugared-lemming-812.notion.site/Git-Convention-d81d12da8c3244faae31bd111e930897)

<br/>

# 🐉 Workflow
![hous_workflow](https://user-images.githubusercontent.com/74812188/180251210-2bfbf298-a8f6-4400-b14f-ea5b229e15e7.png)

<br/>

# ❗️About Service

### 🛖 함께 한 집에 살며 느꼈던 고민과 고충! Hous-가 해결해줄께요. 🛖
> 청소에 민감하지만 룸메이트는 청소에 민감하지 않아서 결국 다 혼자 청소하지는 않으셨나요? </br>
전혀 상처를 주려고 하지 않았지만, 룸메이트와 성향이 달라 상처를 줘버린 적이 있지는 않으셨나요? </br>
룸메이트와의 평화로운 한집살이를 도와줄 비서 **Hous-** 입니다.

<br />

# 💡 Key Service

<br/>

**✨ 이벤트 등록**<br/><br/>
함께하는 일 혹은 룸메이트들이 알면 좋을 자신의 일정을 이벤트로 등록해 서로의 생활을 공유할 수 있도록 하며 당일 알림을 통해 잊지 않고 기억하게 해줌.<br/><br/>
**✨ 규칙 등록**<br/><br/>
공동 생활에 필요한 규칙을 등록하고 카테고리별 분류를 통해 쉽게 확인하도록 함. 설정한 담당자와 요일에 따라 알림을 받고 규칙을 지켰는지 체크할 수 있음.<br/><br/>
**✨ 성향 테스트**<br/><br/>
하루의 상황과 질문을 제시해 응답을 통해 생활 성향을 확인함. 그래프와 성향 카드를 통해 테스트 결과를 한 눈에 볼 수 있도록 하며, 이는 룸메이트간 서로에 대한 이해를 도움.

<br />

# 🛠 Development Environment

![Swift](https://img.shields.io/badge/swift-v5.5*-orange?logo=swift)  ![Xcode](https://img.shields.io/badge/xcode-v13.0*-blue?logo=xcode)  ![iOS](https://img.shields.io/badge/iOS-15.0*-green.svg)

<br />

# 📚 Package Dependency

| Name | Tag | Management Tool |
| :-: | :-: | :-: |
| SnapKit | Layout | SPM |
| Then | Layout, Sugar API | SPM |
| Alamofire | Network | SPM |
| Inject | Build | SPM |
| RxGesture | RxLibrary | SPM |
| RxSwift | RxLibrary | SPM |
| Lottie | Splash | SPM |

<br />

# 📁 Project Structure

```swift
.
├── Global
│   ├── Extension
│   ├── Resource
│   │   ├── Assets.xcassets
│   │   │   ├── Common
│   │   │   ├── Home
│   │   │   ├── Rules
│   │   │   └── Profile
│   │   └── Font
│   ├── Supports
│   │   ├── AppDelegate.swift
│   │   ├── Info.plist
│   │   └── SceneDelegate.swift
│   └── UIComponent
├── Network
│   ├── API
│   ├── HTTP
│   └── Model
└── Screens
    ├── Home
    ├── Rules
    ├── Profile
    ├── Splash
    └── Tabbar
```

<br />

# 🍎 Hous- iOS Developers

| 지현<img src="https://user-images.githubusercontent.com/60292150/178426997-5ddd73fe-5edb-458f-9192-51a7963a3abc.png" width="200" height="200"/> | 민재<img src="https://user-images.githubusercontent.com/60292150/178427691-c527cca9-2efe-4fc6-a9fa-b7958901b67a.png" width="200" height="200"/> | 의진<img src="https://user-images.githubusercontent.com/60292150/178427724-e9fb4a5b-d610-494a-a81e-e09578f27c6b.png" width="200" height="200"/> | 호세<img src="https://user-images.githubusercontent.com/60292150/178427752-774f87bf-7a7d-4311-8657-1104731e4f8f.png" width="200"  height="200" /> |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|                          **김지현**                          |                          **김민재**                          |                          **이의진**                          |                          **김호세**                          |
|          [@Jihyun247](https://github.com/Jihyun247)          |           [@ffalswo2](https://github.com/ffalswo2)           |           [@pabby](https://github.com/lee-euijin)            |         [@psychehose](https://github.com/psychehose)         |

---

<br />

# ⚒️ 각자 맡은 기능

<br />

## 김지현

>  규칙탭 - 카테고리 , 오늘의 Todo, 나의 Todo, 카테고리 별 규칙 조회, 카테고리 추가,수정,삭제

<img width="989" alt="스크린샷 2022-07-22 오후 4 34 07" src="https://user-images.githubusercontent.com/59338503/180388452-39c87b9e-fb0a-4e3f-a57f-74e899179aa0.png">
<img width="995" alt="스크린샷 2022-07-22 오후 4 34 51" src="https://user-images.githubusercontent.com/59338503/180388463-ae2d9e2f-3cf7-4b72-814e-4f1ef28724b7.png">

### 뷰 구조

```swift
├── 📱Rules
    ├── 📱RulesTodo
    │       ├── TodayTodo
    │       └── MyTodo
    ├── 📱Category
    └── 📱CategoryEdit
            ├── Add
            └── Update

```

------

규칙탭은 depth가 깊지 않고 하나의 뷰 내에서 모든 기능이 존재하기 때문에

하나의 뷰 내에서 SubView가 세가지 경우에 따라 다르게 존재하고, 그 SubView 의  SubView Case를 나누어 구현했습니다.

### 구현 방식

	1. 오늘의 Todo & 나의 Todo / Category / Category 추가 수정  세가지 뷰로 나누어 구현했습니다.
	2. 오늘의 Todo & 나의 Todo enum을 정의하고 case에 따라 cell을 다르게 dequeue 해주었습니다.
	3. Category 추가 수정 또한 enum을 정의하고 case에 따라 같은 View를 재사용하며 다른 기능을 구현했습니다.

<br />

## 김민재



<br />

## 이의진

### ⚡ 맡은 뷰

- `Profile Main View` → 프로필 정보, 성격 유형별 컬러 적용, 성향 테스트 결과 그래프 애니메이션 기능
- `Profile` - 성향 테스트 결과 뷰 → 프로필 성향 결과에 맞는 뷰를 보여줌
- `Profile` - Setting 뷰

### 1️⃣ View Layout 구현 방식

- `전체적인 레이아웃은 Navigation Bar View Component + CollectionView LayOut을 이용하여 구현하였습니다.`
- `Enum 을 적극적으로 이용 → Hous- 의 경우 다섯 가지 성격 유형이 있고, 각 성격별로 컬러, 프로필 이미지 등이 대부분의 뷰에 일괄 적용이 되는 특성을 가지고 있습니다. → 이 다섯 가지 특성에 대응되는 프로퍼티들을 Enum에 정리하여 차후 업데이트 시 Enum만 수정해주면 모든 뷰에 일괄 적용이 가능하게 설계되었습니다. → 또한 다섯 가지 특성이 적용되는 뷰에서 일일이 Switch 문을 작성할 필요가 없어 코드가 더욱 간결해집니다.`
- `레이아웃 구현은 configUI(), render() 함수를 컨벤션으로 하여 공통 적용하여 then, Snapkit 라이브러리를 활용해 구현하였습니다.`

### 2️⃣ Graph View 및 Animation 구현 방식

- `그래프가 그려져야 하는 점의 좌표를 얻어내는 부분과 점이 주어졌을 때 그래프를 화면에 표현해주는 부분으로 나누어 구현하였습니다.`
- `그래프 점의 좌표는 중심점 벡터와 극 좌표계를 이용해 표현한 벡터를 합하는 방식으로 얻어냈습니다.`
- `애니메이션은 애니메이션 시작 BezierPath와 애니메이션 끝 BezierPath를 CAAnimation 에 ease 옵션을 주어서 얻어내는 방식으로 구현했습니다.`

### 3️⃣ 서버 연결 구현 방식

- `지현이가 구현해 준 Network Layer로부터 NetworkResponse 를 가져옵니다.`
- `뷰에 직접 데이터를 적용할 수 있는 데이터 포맷인 DataPack 을 정의합니다.`
- `NetworkResponse 포맷을 DataPack 포맷으로 전환하는 ConvertResponseToDataPack 함수를 구현합니다.`
- `DataPack 을 각 뷰에 적용하는 setData 함수를 구현하여 서버 연결을 마무리합니다.`
- `위와 같은 일관된 플로우로 통신 로직을 구현하여, 차후 업데이트 사항이 있을 때 효과적으로 대응할 수 있도록 하였습니다.`

<br />

## 김호세

>  이번에 내가 앱잼에서 맡은 부분은 커스텀 탭바와 새로운 규칙을 수정하거나, 추가하는 뷰이다. 

- 커스텀 탭바는  UITabbarController에 위에 존재하는 tabbar를 숨김 처리하고  커스텀한 Tabbar를 올렸고 RxSwift, RxCocoa, RxGestures를 이용해서  아이템 간의 이벤트를 발생 및 구독  했다.

- 규칙 추가, 수정하는 뷰는 먼저 드랍다운이 들어가 있어서, 라이브러리를 쓸까 말까 고민하다가 직접 구현하는 방식으로 갔었는데 드랍다운 탭 이벤트를 주기가 좀 복잡했다.  (좌표계산이 좀 까다로웠음..)

<br />

# 😲 어려웠던 점 및 극복 과정

<br />

## 김지현

Hous- 는 User 마다 성향테스트 결과에 따른 `TypeColor`가 존재하고 서버에서 `String`으로 받아오기 때문에 받아온 `String`을 경우에 따라 네가지로 변환해야 합니다.

	1. typeColor에 따른 다양한 색의 지정 UIColor
	2. typeColor에 따른 다양한 색의 배경 UIColor
	3. typeColor에 따른 다양한 색의 얼굴 이모지
	4. typeColor에 따른 다양한 색의 체크된 얼굴 이모지

하지만 서버통신을 할 때마다 조건문을 사용하여 TypeColor에 따른 분기처리를 했더니 중복 코드가 굉장히 많아졌습니다.

이 부분을 `Factory Pattern` 으로 객체 생성을 캡슐화 하였습니다.

```swift
enum AssigneeColor: String {
  case yellow, blue, purple, red, green, gray, none
}

protocol AssigneeProtocol {
  var checkedFaceImage: UIImage { get set }
  var faceImage: UIImage { get set }
  var color: UIColor { get set }
  var profileBackgroundColor: UIColor { get set }
}

struct YellowAssignee: AssigneeProtocol {
  var checkedFaceImage = R.Image.faceCheckedYellow
  var faceImage = R.Image.faceYellow
  var color = R.Color.paleGold
  var profileBackgroundColor = R.Color.offWhite
}

// 생략

struct AssigneeFactory {
  
  static func makeAssignee(type: AssigneeColor) -> AssigneeProtocol {
    switch type {
    case .yellow:
      return YellowAssignee()
		//생략
    }
  }
}
```

다음과 같이 사용할 수 있습니다.

```swift
let assignee = AssigneeFactory.makeAssignee(type: AssigneeColor(rawValue: data.typeColor.lowercased()))

participantButton.setBackgroundImage(assignee.faceImage, for: .normal)
participantButton.setBackgroundImage(assignee.checkedFaceImage, for: .selected)
```

<br />

## 김민재



<br />

## 이의진

[👉 프로젝트 진행 간 어려웠던 점과 해결 과정](https://working-umbrella-4d9.notion.site/7719b0272caf46089c7a65b0389a88ee)

<br />

## 김호세

1️⃣ 

```
하우스 프로젝트를 진행하면서 어려웠던 부분은 새로운 규칙을 추가할 때, 유저 인터렉션에 따라 변하는 UI 로직 처리였다.  해결은 Dictionary를 이용해서 인터렉션마다 업데이트를 하는 방식으로 했다. 
```

2️⃣ 

```
개발이라는 것 특성상 협업할 확률이 높은데 Git에 대해서 좀 더 자세히 알 필요가 있다고 생각해서( 사실 그냥 One-line이 예뻐서 )  git rebase merge + git flow를 도입해봤다. 
rebase를 하게 되면 merge 보다 훨씬 충돌이 많이 발생하는데 초기에는 팀원들이 이것에 대해서 걱정했었다. 지금 이 글을 쓰는 시점에서 다들 git rebase에 대해 큰 부담감을 가지지 않고 충돌에 더 여유로워진 모습을 봐서 나름 뿌듯했다.
```

3️⃣ 

```
또한 Injection을 도입해봤는데 개인적으로도 나름 유용하게 사용하고 있기도 하고 팀원들이 마음에 들어하는 거 같아서 좋았다. 다만 보통 사용할 때는, Test App Target을  만들고 작업을 하는데 좀만 더 신경 써서, 그 부분도 도입했으면 좋지 않았을까 하는 아쉬움이 들었다.
```



<br />
