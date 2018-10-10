
#import <UIKit/UIKit.h>

@interface BTWActionAlertCell : UITableViewCell

@property (nonatomic, strong) NSString *actionText;
@property (nonatomic, assign) CGFloat bottomLineWidth;
@property (nonatomic, assign, getter=isShowBottomLine) BOOL showBottomLine;
@property (nonatomic, assign, getter=isShowDefaultSelectStyle) BOOL showDefaultSelectStyle;
@property (nonatomic, assign, getter=isCheakCell) BOOL cheakCell;


@end
