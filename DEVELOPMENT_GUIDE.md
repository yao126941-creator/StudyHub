# StudyHub 开发指南

## 📱 项目结构详解

### App/
应用入口和主导航

- `StudyHubApp.swift` - 应用入口，配置 CoreData
- `ContentView.swift` - 主视图，包含三个标签页面

### Models/
数据模型（CoreData Entity）

- `Task.swift` - 学习任务模型
- `TimerRecord.swift` - 计时记录模型

### Views/
UI 视图组件

- `TaskListView.swift` - 任务管理界面
  - 展示进行中和已完成的任务
  - 支持创建、删除、标记完成
  
- `TimerView.swift` - 番茄计时界面
  - 25 分钟工作 + 5 分钟休息
  - 可暂停/重置/完成
  
- `StatisticsView.swift` - 数据统计界面
  - 今日学习时长
  - 周学习时长
  - 任务完成率
  - 最近学习记录

### ViewModels/
视图模型，处理业务逻辑

- `TimerViewModel.swift` - 计时器逻辑
  - 时间倒计时
  - 模式切换（工作/休息）
  - 进度计算

### Services/
业务服务层

- `PersistenceController.swift` - CoreData 管理
  - 持久化存储
  - 保存/删除操作
  
- `TaskService.swift` - 任务业务逻辑
  - 创建、查询、更新、删除任务
  - 任务过滤（进行中/已完成）

---

## 🛠️ 环境要求

- Xcode 15.0+
- Swift 5.9+
- iOS 15.0+ 

---

## 🚀 快速开始

### 1. 打开项目
```bash
cd StudyHub
open StudyHub.xcodeproj
```

### 2. 选择模拟器
- 在 Xcode 顶部选择 iPhone 模拟器（推荐 iPhone 15）

### 3. 运行应用
- 按 `Cmd + R` 或点击播放按钮

---

## 📝 核心功能实现

### 创建任务
```swift
let task = TaskService.shared.createTask(
    title: "学习 Swift",
    estimatedMinutes: 25,
    context: viewContext
)
```

### 启动计时器
```swift
timerViewModel.toggleTimer() // 开始计时
```

### 查询学习数据
```swift
let records = timerRecords
    .filter { calendar.isDate($0.date, inSameDayAs: Date()) }
```

---

## 🔧 CoreData 配置

CoreData 数据库存储在：
- iOS 模拟器：`~/Library/Developer/CoreSimulator/Devices/[Device ID]/data/Containers/Data/Library/Application Support/StudyHub`

清空数据库：
1. 删除应用
2. 清理 Build Folder（Cmd + Shift + K）
3. 重新运行

---

## 📊 下一阶段开发计划

### Phase 2: 增强功能
- [ ] 数据导出（CSV/PDF）
- [ ] 学习笔记功能
- [ ] 任务分类和标签
- [ ] 学习提醒通知

### Phase 3: 云端同步
- [ ] Firebase 集成
- [ ] iCloud 同步
- [ ] 多设备支持

### Phase 4: 社交功能
- [ ] 学习圈子
- [ ] 排行榜
- [ ] 分享成就

---

## 🐛 常见问题

### Q: 计时器不运行？
A: 检查 `TimerViewModel` 中的 `Timer` 是否正确初始化

### Q: 数据没有保存？
A: 确保调用了 `PersistenceController.shared.save()`

### Q: UI 显示不正常？
A: 清空模拟器数据并重新运行应用

---

## 📚 参考资源

- [Apple SwiftUI 文档](https://developer.apple.com/documentation/swiftui)
- [CoreData 指南](https://developer.apple.com/documentation/coredata)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines)

---

## 💡 代码风格指南

- 使用 MARK 注释分组代码
- 视图函数使用 `var` 而不是 `func`
- 环境变量统一在视图顶部声明
- 私有方法使用 `private` 修饰符

---

**祝开发愉快！有问题随时联系。** 🎉
