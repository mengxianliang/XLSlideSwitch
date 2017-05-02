# XLSlideSwitch

### 显示效果：

| 样式 | 正常显示标题 | 在NavigationBar上显示标题 |
| ---- | ---- | --- |
|标准样式| <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/1-1.gif" width=200 height=360 /> | <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/2-1.gif" width=200 height=360 /> |
|Segmented样式| <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/1-3.gif" width=200 height=360 /> | <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/2-2.gif" width=200 height=360 /> |


### 使用方法：

#### 1、创建数据源：titles、viewControllers

```objc
    //要显示的标题
    NSArray *titles = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
    //创建需要展示的ViewController
    NSMutableArray *viewControllers = [NSMutableArray new];
    for (int i = 0 ; i<titles.count; i++) {
        TestViewController *vc = [TestViewController new];
        vc.delegate = self;
        [viewControllers addObject:vc];
    }
```

#### 2、创建滚动视图

```objc
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    //设置代理
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.itemSelectedColor = RedColor;
    _slideSwitch.itemNormalColor = GrayColor;
    //设置要显示的视图集合
    _slideSwitch.viewControllers = viewControllers;
    //设置标题
    _slideSwitch.titles = titles;
    [self.view addSubview:_slideSwitch];
```

#### 3、代理方法


```objc
-(void)slideSwitchDidselectTab:(NSUInteger)index{
    NSLog(@"切换到了第 -- %zd -- 个视图",index);
}
```

### 实现原理请参考[我的博文](http://blog.csdn.net/u013282507/article/details/54022276)
