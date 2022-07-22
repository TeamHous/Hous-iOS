# Hous-iOS

<div align="center">

![KakaoTalk_Photo_2022-07-22-07-03-05](https://user-images.githubusercontent.com/60493070/180322745-92fdc3f3-9300-4c3a-9f93-211354ee5725.png)

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

</div>

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

![Swift](https://img.shields.io/badge/swift-v5.5*-orange?logo=swift)![Xcode](https://img.shields.io/badge/xcode-v13.0*-blue?logo=xcode)![iOS](https://img.shields.io/badge/iOS-15.0*-green.svg)

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

	1. `오늘의 Todo & 나의 Todo` / `Category` / `Category 추가 수정`  세가지 뷰로 나누어 구현했습니다.
	1. 오늘의 Todo & 나의 Todo enum을 정의하고 case에 따라 cell을 다르게 dequeue 해주었습니다.
	1. `Category` 추가 수정 또한 enum을 정의하고 case에 따라 같은 View를 재사용하며 다른 기능을 구현했습니다.



## 김민재



## 이의진



## 김호세



<br />

# 😲 어려웠던 점 및 극복 과정



## 김지현

Hous- 는 User 마다 성향테스트 결과에 따른 `TypeColor`가 존재하고 서버에서 `String`으로 받아오기 때문에 받아온 `String`을 경우에 따라 네가지로 변환해야 합니다.

	1. `typeColor에 따른 다양한 색의 지정 UIColor`
	1. `typeColor에 따른 다양한 색의 배경 UIColor`
	1. `typeColor에 따른 다양한 색의 얼굴 이모지`
	1. `typeColor에 따른 다양한 색의 체크된 얼굴 이모지`

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



## 김민재



## 이의진



## 김호세



<br />
