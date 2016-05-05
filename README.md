####简介  
用法简单的iOS图片选择库  
项目主页：https://github.com/DaMingShen/SuPhotoPicker  
1、只需两行代码搞定  
2、仿QQ图片选择界面  

####如何导入  
cocoapods导入：```暂无```  
手动导入：将 SuPhotoPicker 文件夹拽入项目中  


####如何使用  
1、导入主头文件：  
```
#import "SuPhotoPicker.h"
```
2、创建一个图片选择库实例并选择其显示界面  
```
SuPhotoPicker * picker = [[SuPhotoPicker alloc]init];  
//最大选择图片的数量以及最大快速预览图片的数量，默认为20  
picker.selectedCount = 12;  
picker.preViewCount = 15;  
//现在在界面上  
[picker showInSender:self handle:^(NSArray<UIImage *> *photos) {  
        //完成选择后的操作  
    }];  
```

####效果图  
1、快速预览界面及图片选择（GIF 3.4M）  
  
![SuPhotoPicker.gif](http://upload-images.jianshu.io/upload_images/1644426-44525c3a67704157.gif?imageMogr2/auto-orient/strip)
  
2、相册界面及图片选择（GIF 1.2M）  
  
![SuPhotoPicker - album.gif](http://upload-images.jianshu.io/upload_images/1644426-d1a97ae0d530bafe.gif?imageMogr2/auto-orient/strip)
  
3、图片预览界面及图片选择（GIF 6.7M）  
  
![SuPhotoPicker - album - preview.gif](http://upload-images.jianshu.io/upload_images/1644426-80fb190de7a955be.gif?imageMogr2/auto-orient/strip)
  
4、相机使用功能无法录制GIF，请在真机上实际使用体验  

####提醒  
本工具纯ARC，由于使用Photos库来实现，要求iOS8.0以上系统  

####期待
1、大牛们能提供建议（包括优化和完善功能）  
2、使用中遇到BUG，请联系我，谢谢  
3、小伙伴能输出代码，Pull Requests我  
4、本库能帮助到大家 ^_^  
