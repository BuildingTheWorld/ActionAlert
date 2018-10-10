
#import <UIKit/UIKit.h>

/**
 ActionCell选中样式

 - ActionSelectStyleGrey: UITableViewCellSelectionStyleDefault样式
 - ActionSelectStyleCheckmark: 对号样式
 */
typedef NS_ENUM(NSUInteger, BTWActionSelectStyle) {
    BTWActionSelectStyleGrey,
    BTWActionSelectStyleCheckmark,
};

/**
 action 响应了事件

 @param index actionTitleArray 的 index
 */
typedef void(^BTWActionSelectBlock)(NSInteger index);

/**
 ActionAlertController 移除回调
 */
typedef void(^BTWAlertCDidRemoveBlock)(void);

@interface BTWActionAlertController : UIViewController

/**
 初始化 无title 的 alert

 @param actionTitles action字符串数组
 @param selectStyle actionCell selectStyle
 */
- (instancetype)initWithActionTitleArray:(NSArray<NSString *> *)actionTitles actionSelectStyle:(BTWActionSelectStyle)selectStyle;

/**
 初始化 有title 的 alert

 @param title alert 的 title
 @param actionTitles action 的字符串数组
 @param selectStyle actionCell selectStyle
 */
- (instancetype)initWithTitle:(NSString *)title actionTitleArray:(NSArray<NSString *> *)actionTitles actionSelectStyle:(BTWActionSelectStyle)selectStyle;

/**
 展示 alert
 */
- (void)showAlertFromTargetViewController:(UIViewController *)targetViewController;

/**
 移除 alert
 */
- (void)disappearAlert;

@property (nonatomic, strong) BTWActionSelectBlock actionSelectBlock;
@property (nonatomic, strong) BTWAlertCDidRemoveBlock alertCDidRemoveBlock;

@end
