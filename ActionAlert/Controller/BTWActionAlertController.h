

#import "BTWFormSheetBaseViewController.h"

/**
 ActionCell选中样式

 - BTWActionSelectStyleGrey: UITableViewCellSelectionStyleDefault样式
 - BTWActionSelectStyleCheckmark: 对号样式
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
 BTWActionAlertController 移除回调
 */
typedef void(^BTWAlertCDidRemoveBlock)(void);

@interface BTWActionAlertController : BTWFormSheetBaseViewController

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
- (void)showAlert;

/**
 移除 alert
 */
- (void)removeAlert;

@property (nonatomic, strong) BTWActionSelectBlock actionSelectBlock;
@property (nonatomic, strong) BTWAlertCDidRemoveBlock alertCDidRemoveBlock;

@end
