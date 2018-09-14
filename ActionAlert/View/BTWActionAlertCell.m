

#import "BTWActionAlertCell.h"

//#import <Masonry.h>

@interface BTWActionAlertCell ()
{
    BOOL _isShowCheakmark;
}

@property (nonatomic, strong) UILabel *actionLabel;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIImageView *cheakMarkImageView;

@end

@implementation BTWActionAlertCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (_isShowCheakmark == YES) {
        self.cheakMarkImageView.hidden = selected ? NO : YES;
    }
}

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self setupSubViews];
    }
    return self;
}

#pragma mark - setup subViews

- (void)setupSubViews
{
    [self.contentView addSubview:self.actionLabel];
//    [self.actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.offset(0);
//        make.left.offset(20);
//    }];
    
    [self.contentView addSubview:self.bottomLine];
    
    [self.contentView addSubview:self.cheakMarkImageView];
//    [self.cheakMarkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.offset(24);
//        make.centerY.offset(0);
//        make.right.offset(-20);
//    }];
    
}

#pragma mark - setter

- (void)setActionText:(NSString *)actionText
{
    _actionText = actionText;
    
    self.actionLabel.text = actionText;
}

- (void)setBottomLineWidth:(CGFloat)bottomLineWidth
{
    _bottomLineWidth = bottomLineWidth;
    
//    [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.offset(bottomLineWidth);
//        make.centerX.offset(0);
//        make.height.offset(1);
//        make.bottom.offset(0);
//    }];
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    _showBottomLine = showBottomLine;
    
    self.bottomLine.hidden = !showBottomLine;
}

- (void)setShowDefaultSelectStyle:(BOOL)showDefaultSelectStyle
{
    _showDefaultSelectStyle = showDefaultSelectStyle;
    
    if (showDefaultSelectStyle == YES) {
        
        self.cheakMarkImageView.hidden = YES;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        self.cheakMarkImageView.hidden = NO;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

#pragma mark - lazy

- (UILabel *)actionLabel {
    if (_actionLabel == nil) {
        _actionLabel = [[UILabel alloc] init];
    }
    return _actionLabel;
}

- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
//        _bottomLine.backgroundColor = ;
    }
    return _bottomLine;
}

- (UIImageView *)cheakMarkImageView {
    if (_cheakMarkImageView == nil) {
        _cheakMarkImageView = [[UIImageView alloc] init];
        _cheakMarkImageView.image = [UIImage imageNamed:@""];
        _cheakMarkImageView.hidden = YES;
    }
    return _cheakMarkImageView;
}

@end