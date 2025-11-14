#import <UIKit/UIKit.h>
#import "MyToolBar.h"

// 防止未安装 Logos 的环境
%ctor {
    @autoreleasepool {
        // nothing here; hooks below will run
    }
}

%hook NSObject // 使用通用 hook，尝试多种类名的 layoutSubviews
// 优先尝试已知的微信输入类名
- (void)layoutSubviews {
    %orig;

    @autoreleasepool {
        // 检查当前对象是否是我们关心的输入 toolbar 类之一（字符串匹配，避免类不存在崩溃）
        NSString *clsName = NSStringFromClass([self class]);

        NSArray *candidates = @[@"MMInputToolView", @"InputToolViewBar", @"MMInputToolBar", @"WCInputToolBar"];
        if (![candidates containsObject:clsName]) {
            return;
        }

        // 防止重复添加
        NSInteger tag = 0xBEEF001;
        UIView *exist = [(UIView *)self viewWithTag:tag];
        if (exist) return;

        // 计算宽度和高度（参考值）
        CGFloat width = ((UIView *)self).bounds.size.width;
        if (width <= 0) width = [UIScreen mainScreen].bounds.size.width;
        CGFloat toolbarH = 44.0;

        // 创建并添加
        MyToolBar *bar = [[MyToolBar alloc] initWithFrame:CGRectMake(0, -toolbarH, width, toolbarH)];
        bar.tag = tag;
        bar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

        // 这里用 addSubview 而非 insertSubview: below ... 以便不影响输入栏原有按钮布局
        [(UIView *)self addSubview:bar];

        // 如果需要可调整父视图高度或 contentInset —— 示例里不改动微信布局，仅浮于上方
    }
}
%end
