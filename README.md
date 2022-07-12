# Hous-iOS
<div align="center">

![하우스한줄소개](https://user-images.githubusercontent.com/60292150/178424666-f91b89aa-6134-4f44-80bb-2d2abd18d643.jpg)

## 공동생활을 위한 슬기로운 룸메이트 가이드 서비스
`30th SOPT APPJAM`
</br>
</br>
🗓  2022.7.2 ~ ing.
</br>
</br>

<br /> 

### 🍎 Hous- iOS Developers
|![지현](https://user-images.githubusercontent.com/60292150/178426997-5ddd73fe-5edb-458f-9192-51a7963a3abc.png)|![민재](https://user-images.githubusercontent.com/60292150/178427691-c527cca9-2efe-4fc6-a9fa-b7958901b67a.png)|![의진](https://user-images.githubusercontent.com/60292150/178427724-e9fb4a5b-d610-494a-a81e-e09578f27c6b.png)|![호세](https://user-images.githubusercontent.com/60292150/178427752-774f87bf-7a7d-4311-8657-1104731e4f8f.png)|
|:--:|:--:|:--:|:--:|
|**김지현 `lead`**|**김민재**|**이의진**|**김호세**|
|          [@Jihyun247](https://github.com/Jihyun247)          |           [@ffalswo2](https://github.com/ffalswo2)           |              [@pabby](https://github.com/lee-euijin)              | [@psychehose](https://github.com/psychehose) |

---


</div>

<br />

## 🛠 Development Environment
![Swift](https://img.shields.io/badge/swift-v5.5*-orange?logo=swift)
![Xcode](https://img.shields.io/badge/xcode-v13.0*-blue?logo=xcode)
![iOS](https://img.shields.io/badge/iOS-15.0*-green.svg)

## 📚 Package Dependency
| Name | Tag | Management Tool |
| --- | --- | --- |
| SnapKit | Layout | SPM |
| Then | Layout, Sugar API | SPM |
| Alamofire | Network | SPM |
| Inject | Build | SPM |
| RxGesture | RxLibrary | SPM |
| RxSwift | RxLibrary | SPM |

<br />
<br />

## ✍🏻 Conventions
<details>
<summary> Code Conventions </summary>
<div markdown="1">

<br>

##  Convention 1. 모든 View는 CodeBase로 작성합니다.
- 구체적인 Coding Convention은 자율적으로 진행합니다.

## Convention 2. 파일명은 Zeplin 기반 파일명으로 구성합니다.
- 파일명은 Zeplin에 명시된 파일명을 기반으로 작성합니다.
- 앞에 탭을 명시합니다.

## Convention 3. 파일명은 줄여쓰지 않습니다.
- `VC`  가 아닌 `ViewController`  이렇게 줄이지 않고 작성합니다.

## Convention 4. 파라미터와 리턴 타입이 없는 Closure는 정의 시 () -> Void 를 사용합니다.

```
let completionBlock: (() -> Void)?
```

## Convention 5. 임포트는 관련 있는 모듈끼리 묶어 알파벳 순으로 임포트합니다.

```
import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
```

- 관련있는 라이브러리는 묶어서 임포트합니다.
- 같은 종류의 라이브러리를 나열 시에는 abc 순으로 나열합니다.
- 공백인 라인 없이 나열합니다.

## Convention 6. Constraints 초기화 메서드는 render(), UI 초기화 메서드는 configUI() 를 이용합니다.

- Constrsints 세팅 메서드 명 `render()`
- UI 초기화 메서드 명 `configUI()`

</div>
</details>

<details>
<summary> Git Flow </summary>
<div markdown="2">

<br>

# 기본 브랜치는 develop 입니다

## Git Flow

```swift
1. Issue를 생성한다.
2. feature Branch를 생성한다.
3. Add - Commit - Push - Pull Request 의 과정을 거친다.
4. Pull Request가 작성되면 작성자 이외의 다른 팀원이 Code Review를 한다.
5. Code Review가 완료되면 Pull Request 작성자가 develop Branch로 merge 한다.
6. 종료된 Issue와 Pull Request의 Label과 Project를 관리한다.
```

- 이 중 3 ~ 5의 과정은 `git rebase` 를 활용하며 방법은 아래와 같습니다.

```
git rebase 하는 법

1. git fetch --all
2. git switch develop
3. git pull -r (develop 브랜치를 항상 최신으로 유지할 것)
4. git switch 'your Branch'
5. git rebase develop
6. 컨플릭 해결하세요
7. git push 'your feature' (리모트에 올려주세요)
8. PR 날리기
9. Github에서 merge 버튼 누르는 것이 아님!
10. git switch develop
11. git fetch --all
12. git merge --ff-only 'your feature'
13. git push

```

## Issue Convention

```swift
[<PREFIX>] <Description>

ex. [FEAT] 로그인뷰 전체 레이아웃 구현
```

## Branch Convention

```swift
<Prefix>/#<Issue_Num>

ex.
feature/#5
```
**앱잼 기간에는 `feature` , `bugfix` 브랜치를 만들어 작업하고 `develop` 에 머지 합니다**

## Commit Convention

```swift
[#<Issue_Num>] <PREFIX> : <Description>

ex.
[#5] FEAT : LoginView Custom TextField
```

## Pull Request Convention

```swift
[#<Issue_Num>] <PREFIX> :  <Description>

ex.
[#20] FEAT : 로그인뷰 전체 레이아웃
```
</div>
</details>


<br />
<br />

## 📁 Project Structure
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
│   └── UIComponent // 재사용되는 커스텀뷰 커스텀버튼 등
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
