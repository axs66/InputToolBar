#import "MyToolBar.h"
#import <objc/runtime.h>

@implementation MyToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.06];
    self.clipsToBounds = YES;

    // 左侧一个图标按钮（示例）
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(8, 6, 32, 32);
    btn.layer.cornerRadius = 6;
    btn.backgroundColor = [[UIColor systemBlueColor] colorWithAlphaComponent:0.12];
    [btn setTitle:@"样" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [btn addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:btn];

    // 一个右侧的“更多”按钮（示例）
    UIButton *more = [UIButton buttonWithType:UIButtonTypeSystem];
    more.frame = CGRectMake(self.bounds.size.width - 44, 6, 36, 32);
    more.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [more setTitle:@"···" forState:UIControlStateNormal];
    more.titleLabel.font = [UIFont systemFontOfSize:20];
    [more addTarget:self action:@selector(tapMore:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:more];
}

- (void)tapButton:(id)sender {
    // 演示：复制一段文本到剪贴板并显示短暂提示（避免直接调用微信内部接口）
    UIPasteboard.generalPasteboard.string = @"[来自自定义工具栏：演示文本]";
    [self showTempHUD:@"已复制到剪贴板"];
}

- (void)tapMore:(id)sender {
    [self showTempHUD:@"更多功能（在这里实现弹出面板）"];
}

- (void)showTempHUD:(NSString *)text {
    // 简单 HUD：短暂 label
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectZero];
    lbl.text = text;
    lbl.textColor = [UIColor whiteColor];
    lbl.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    lbl.font = [UIFont systemFontOfSize:13];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.layer.cornerRadius = 6;
    lbl.clipsToBounds = YES;
    lbl.alpha = 0.0;

    CGSize sz = [lbl sizeThatFits:CGSizeMake(260, 200)];
    sz.width += 20; sz.height += 10;
    CGRect f = CGRectMake((self.bounds.size.width - sz.width)/2.0, -sz.height - 8, sz.width, sz.height);
    lbl.frame = f;
    lbl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:lbl];

    [UIView animateWithDuration:0.22 animations:^{
        lbl.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.22 delay:1.0 options:0 animations:^{
            lbl.alpha = 0.0;
        } completion:^(BOOL finished2) {
            [lbl removeFromSuperview];
        }];
    }];
}

@end
