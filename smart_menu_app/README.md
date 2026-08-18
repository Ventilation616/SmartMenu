# SmartMenu App

SmartMenu 是一个本地料理配方管理应用。V1.0 聚焦于一个核心能力：

> 在编辑配方时，用户修改一个参与比例计算的食材用量，保存后系统自动按比例重算其他参与计算的食材。

当前已完成 M1、M2 两个阶段，具体包括：

- Flutter 工程初始化
- Riverpod / go_router / Drift / Freezed / Decimal 依赖接入
- 分层目录结构
- 应用入口、路由和页面骨架
- 基础代码生成与静态检查配置
- `freezed` 领域模型与值对象
- Drift 数据库连接与代码生成
- `recipes`、`ingredients`、`cooking_steps` 表结构
- 配方、食材、步骤 DAO
- 配方仓储实现与数据映射
- 基于事务的整配方写入能力

## 当前能力范围

当前工程已经具备：

- 可运行的 Flutter 应用骨架
- 配方、食材、步骤的数据持久化基础设施
- 配方列表查询、名称搜索、详情查询、保存、删除所需的数据访问接口

当前工程尚未完成：

- Decimal 精度工具与取整算法
- 配方保存校验
- 新建配方用例
- 编辑保存时的动态比例计算
- 页面与数据库的完整业务联动

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

M3 将继续实现以下内容：

- Decimal 精度与取整工具
- 配方业务校验规则
- 新建配方用例
- 编辑保存时的动态比例计算用例
- 删除、查询、搜索等基础用例
