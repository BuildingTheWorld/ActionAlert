
#import "BTWActionAlertTitleView.h"

//#import <Masonry.h>

@interface BTWActionAlertTitleView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation BTWActionAlertTitleView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubViews];
    }
    return self;
}

#pragma mark - setup subViews

- (void)setupSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.offset(0);
//    }];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
//        make.height.offset(0.5);
//        make.bottom.offset(0);
//    }];
}

#pragma mark - setter

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    
    self.titleLabel.text = titleText;
}

#pragma mark - lazy

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

@end
