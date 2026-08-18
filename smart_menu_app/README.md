# SmartMenu App

SmartMenu 是一个本地料理配方管理应用。V1.0 聚焦于一个核心能力：

> 在编辑配方时，用户修改一个参与比例计算的食材用量，保存后系统自动按比例重算其他参与计算的食材。

当前已完成 M1 工程骨架，包括：

- Flutter 工程初始化
- Riverpod / go_router / Drift / Freezed / Decimal 依赖接入
- 分层目录结构
- 应用入口、路由和页面骨架
- 基础代码生成与静态检查配置

## 目录结构

```text
lib/
├── app/
├── core/
├── data/
├── domain/
└── presentation/
```

## 本地开发命令

```bash
flutter pub get
flutter run
dart run build_runner build
flutter analyze
flutter test
```

## PowerShell 脚本

仓库内提供了便于本地使用的脚本：

```powershell
./tool/build.ps1 pub-get
./tool/build.ps1 codegen
./tool/build.ps1 analyze
./tool/build.ps1 test
```

## 下一阶段

M2 开始实现以下内容：

- 领域模型与值对象
- Drift 数据库表结构
- DAO 与仓储
- Decimal 精度处理与业务校验
