# XLSlideSwitch

### 显示效果：

| 样式 | 正常显示标题 | 在NavigationBar上显示标题 |
| ---- | ---- | --- |
|标准样式| <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/1-1.gif" width=200 height=360 /> | <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/2-1.gif" width=200 height=360 /> |
|按钮居中| <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/1-2.gif" width=200 height=360 /> | <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/2-3.gif" width=200 height=360 /> |
|Segmented样式| <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/1-3.gif" width=200 height=360 /> | <img src="https://github.com/mengxianliang/XLSlideSwitch/blob/master/GIF/2-2.gif" width=200 height=360 /> |


### 使用方法：

**1、创建需要展示的ViewController**

```objc
    NSMutableArray *viewControllers = [NSMutableArray new];
    NSArray *titles = @[@"今天",@"是个",@"好日子",@"心想的",@"事儿",@"都能成",@"明天",@"是个",@"好日子",@"打开了家门",@"咱迎春风",@"~~~"];
    for (int i = 0 ; i<titles.count; i++) {
        TestViewController *vc = [TestViewController new];
        vc.title = titles[i];
        vc.delegate = self;
        [viewControllers addObject:vc];
    }
```

**2、创建滚动视图**

```objc
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.btnSelectedColor = RedColor;
    _slideSwitch.btnNormalColor = GrayColor;
    //设置要显示的视图集合
    _slideSwitch.viewControllers = viewControllers;
    [self.view addSubview:_slideSwitch];
```

**3、代理方法**

```objc
//滚动视图时调用的方法 
-(void)slideSwitchDidselectTab:(NSUInteger)index{
    //为避免同时加载数据 可以通过viewWillAppear方法加载数据
    UIViewController * vc = _slideSwitch.viewControllers[index];
    [vc viewWillAppear:YES];
}

//滑动到左边缘，可以处理滑动返回等一些问题
-(void)slideSwitchPanLeftEdge:(UIPanGestureRecognizer *)panParam{
    NSLog(@"");
}
//滑动到又边缘
-(void)slideSwitchPanRightEdge:(UIPanGestureRecognizer *)panParam{
    
}
```

### 实现原理请参考[我的博文](http://blog.csdn.net/u013282507/article/details/54022276)
