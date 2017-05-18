# XLSlideSwitch

### 显示效果：

| 样式 | 正常显示标题 | 在NavigationBar上显示标题 |
| ---- | ---- | --- |
|标准样式| <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/1-1.gif" width=250 height=449 /> | <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/2-1.gif" width=250 height=449 /> |
|Segmented样式| <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/1-2.gif" width=250 height=449 /> | <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/2-2.gif" width=250 height=449 /> |


### 原理简介：

顶部的标题栏是利用UICollectionview实现的；底部视图控制器的切换是利用UIPageViewController实现的。
最大化的优化内存的使用，每个ChildViewController都是随着滚动加载的，避免了同时加载引起的UI卡顿。

### 使用方法：

#### 1、创建数据源：titles、viewControllers

```objc
//要显示的标题
NSArray *titles = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
//创建需要展示的ViewController
NSMutableArray *viewControllers = [NSMutableArray new];
for (int i = 0 ; i<titles.count; i++) {
    TestViewController *vc = [TestViewController new];
    [viewControllers addObject:vc];
}
```

#### 2、创建滚动视图

```objc
_slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) Titles:titles viewControllers:viewControllers];
 //设置代理
_slideSwitch.delegate = self;
//设置按钮选中和未选中状态的标题颜色
_slideSwitch.itemSelectedColor = RedColor;
_slideSwitch.itemNormalColor = GrayColor;
```
**标题显示在ViewController中:**
```objc
[_slideSwitch showInViewController:self];
```
**标题显示在NavigationBar中:**
```objc
[_slideSwitch showInNavigationController:self.navigationController];
```

#### 3、代理方法

```objc
-(void)slideSwitchDidselectTab:(NSUInteger)index{
    NSLog(@"切换到了第 -- %zd -- 个视图",index);
}
```
