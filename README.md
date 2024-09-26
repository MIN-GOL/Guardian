## 项目介绍
守护助手是一款纯血的原生鸿蒙工具类应用，旨在为用户提供人身和设备的安全保护、隐私保护。
让守护成为生活，让生活成为一切！

## 功能模块
【硬件信息】查询设备的可用存储空间、网络信息、屏幕信息、传感器支持信息情况。

【权限管理】注重用户隐私、查看和管理守护助手已开启的权限。

【隐私空间】通过验证图案锁/指纹/人脸识别，访问加密存储的照片，录音，笔记，保留自己的隐私空间。

【联系人同步】通讯录一键体检优化，重复联系人等问题轻松搞定，更能一键同步通讯录。

【室内守护】使用伪装声音改变性别，避开陌生人敲门安全隐患；使用伪装来电保护隐私，隐瞒独身。

【夜路守护】实时行踪监控，亲友同步，附近派出所提供 110 对接，突发情况也不怕。

【摄像头检测】通过手机传感器检测附近电子设备产生的电磁信号，排查隐藏的摄像头。

【手机移动报警】通过传感器检测手机是否被移动，自动响起警报，防止小偷盗取手机。

【虚拟警报器】开启后闪光灯闪烁 + 高分贝警报音，让夜路跟踪的坏人闻风而逃。

## 效果图
![1727323447489.png](https://img.picui.cn/free/2024/09/26/66f4dc91d7a76.png)
![1727323291871.png](https://img.picui.cn/free/2024/09/26/66f4dc188a04b.png)
![1727323263980.png](https://img.picui.cn/free/2024/09/26/66f4dc186e593.png)
![1727323253124.png](https://img.picui.cn/free/2024/09/26/66f4dc1885ff3.png)
![1727323271182.png](https://img.picui.cn/free/2024/09/26/66f4dc18a5b3d.png)
![1727323278879.png](https://img.picui.cn/free/2024/09/26/66f4dc1878678.png)
![1727323308792.png](https://img.picui.cn/free/2024/09/26/66f4dc1e407b3.png)
![1727323318737.png](https://img.picui.cn/free/2024/09/26/66f4dc1e6f0b6.png)


## 目录结构

```
src
├── entryability
│   └── EntryAbility.ets
├── common // 公共封装
│   ├── builders       // 自定义 builder
│   ├── components     // 自定义组件
│   ├── constants      // 自定义常量
│   ├── dialog         // 自定义对话框
│   ├── images         // 图像资源
│   ├── uploads        // 测试的图像资源
│   └── utils          // 通用工具函数
├── manager                     // 管理器模块
│   ├── PermissionManager.ets   // 用户权限管理器
│   ├── ThemeManager.ets        // 主题管理器
│   └── index.ets               // 管理器模块入口
└── pages // 项目页面
    ├── Index.ets                   // 应用主页
    ├── Tabs
    │   ├── HomeTabsComp.ets        // 首页
    │   ├── GuardTabsComp.ets       // 守护中心
    │   └── MyTabsComp.ets          // 我的
    ├── Battery  // 电池管家
    │   └── BatteryIndexPage.ets        // 电池管家主页
    ├── Calendar // 日历清理
    │   ├── CalendarIndexPage.ets       // 日历清理主页
    │   ├── CalendarFraudPge.ets        // 诈骗日历
    │   ├── CalendarOverduePage.ets     // 过期日历
    │   └── CalendarSearchPage.ets      // 搜索日历
    ├── Cleaner  // 手机瘦身
    │   ├── CleanerIndexPage.ets        // 手机瘦身主页
    │   ├── CleanerSelectPage.ets       // 选择清理的页面
    │   └── Compress
    │       └── CompressPhotoPage.ets   // 照片压缩（图片瘦身）
    ├── Contact  // 通讯录 
    │   ├── ContactIndexPage.ets           // 通讯录备份主页
    │   ├── ContactHistoryDetailPage.ets   // 备份历史详情页
    │   ├── ContactHistoryPage.ets         // 备份历史
    │   ├── ContactMergePage.ets           // 合并联系人
    │   ├── ContactOptimizePage.ets        // 优化联系人
    │   ├── ContactSettingsPage.ets        // 通讯录设置页
    │   └── ContactUnknownPage.ets         // 异常联系人
    ├── Guard   // 守护中心
    │   ├── EmergencyContactPage.ets    // 紧急联系人
    │   ├── Indoor
    │   │   ├── IndoorCheckMovePage.ets   // 手机防移动
    │   │   ├── CheckCameraPage.ets       // 摄像头检测
    │   │   └── IndoorIndexPage.ets       // 室内守护
    │   ├── Alarm
    │   │   ├── CountdownPage.ets       // 警报器倒计时
    │   │   └── GuardAlarmPage.ets      // 警报器页面
    │   ├── Fake
    │   │   ├── FakeTelPage.ets         // 伪装来电
    │   │   └── FakeVoicePage.ets       // 伪装声音
    │   └── Outdoor
    │       ├── GuardNightPage.ets        // 夜路守护
    │       └── GuardPolicePage.ets       // 附近派出所
    ├── Hardware
    │   └── HardwareIndexPage.ets         // 硬件信息页
    ├── Privacy  // 隐私空间
    │   ├── PrivacyIndexPage.ets          // 隐私空间主页
    │   ├── PrivacySettingsPage.ets       // 隐私空间设置页
    │   ├── Auth
    │   │   ├── AuthPatternLockSettingsPage.ets      // 图案锁设置
    │   │   ├── AuthPatternLockPage.ets              // 图案锁认证
    │   │   ├── AuthProtectPage.ets                  // 密保页面
    │   │   └── ForgetPasswordPage.ets               // 忘记密码
    │   ├── Note
    │   │   └── NoteIndexPage.ets       // 隐私笔记主页
    │   │   ├── NoteFormPage.ets        // 隐私笔记表单页
    │   └── Recorder
    │       └── RecorderIndexPage.ets   // 隐私录音
    │   ├── Photo
    │   │   ├── PhotoIndexPage.ets     // 隐私照片主页
    │   │   ├── PhotoAddPage.ets       // 添加照片
    │   │   └── PhotoPreviewPage.ets   // 预览照片
    ├── Settings
    │   ├── SettingsIndexPage.ets         // 设置主页
    │   └── SettingsPermissionPage.ets    // 权限管理
    └── User
        └── UserLoginPage.ets       // 用户登录页
```