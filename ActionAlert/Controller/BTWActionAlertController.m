
#import "BTWActionAlertController.h"

//#import <Masonry.h>
#import "BTWActionAlertTitleView.h"
#import "BTWActionAlertCell.h"
#import "BTWActionAlertPresentAnimator.h"
#import "BTWActionAlertDismissAnimator.h"
#import "BTWFormSheetPresentationController.h"

static CGFloat const kTableHeaderHeight = 44;
static CGFloat const kSectionHeaderFooterHeight = 10;
static CGFloat const kHasTitleCellHeight = 48;
static CGFloat const kNoTitleCellHeight = 44;
static CGFloat const kHasSeparatorLineWidth = 315;
static CGFloat const kNoSeparatorLineWidth = 280;

static CGFloat const kHasTitleVCWidth = 355;
static CGFloat const kNoTitleVCWidth = 280;

static NSString * const kCSActionAlertCellID = @"kCSActionAlertCellID";

@interface BTWActionAlertController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate>
{
    CGFloat _vcViewWidth;
    CGFloat _vcViewHeight;
    CGFloat _cellHeight;
    CGFloat _separatorLineWidth;
    BTWActionSelectStyle _selectStyle;
    BOOL _isHasTitle;
    NSString *_titleText;
    NSInteger _defaultIndex;
}

@property (nonatomic, strong) UITableView *actionTableView;
@property (nonatomic, strong) NSArray *modalArray;
@property (nonatomic, strong) BTWActionAlertTitleView *titleView;

@end

@implementation BTWActionAlertController

#pragma mark - init

- (instancetype)initWithActionTitleArray:(NSArray<NSString *> *)actionTitles actionSelectStyle:(CSActionSelectStyle)selectStyle defaultSelectIndex:(NSInteger)defaultIndex
{
    if (self = [self initWithTitle:nil
                  actionTitleArray:actionTitles
                  actionCellHeight:kNoTitleCellHeight
                separatorLineWidth:kNoSeparatorLineWidth
                 actionSelectStyle:selectStyle
                defaultSelectIndex:defaultIndex]) {

        _vcViewWidth = kNoTitleVCWidth;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title actionTitleArray:(NSArray<NSString *> *)actionTitles actionSelectStyle:(CSActionSelectStyle)selectStyle defaultSelectIndex:(NSInteger)defaultIndex
{
    if (self = [self initWithTitle:title
                  actionTitleArray:actionTitles
                  actionCellHeight:kHasTitleCellHeight
                separatorLineWidth:kHasSeparatorLineWidth
                 actionSelectStyle:selectStyle
                defaultSelectIndex:defaultIndex]) {

        _vcViewWidth = kHasTitleVCWidth;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
             actionTitleArray:(NSArray<NSString *> *)actionTitles
             actionCellHeight:(CGFloat)cellH
           separatorLineWidth:(CGFloat)lineWidth
            actionSelectStyle:(BTWActionSelectStyle)selectStyle
           defaultSelectIndex:(NSInteger)defaultIndex
{
    if (self = [super init]) {
        
        if (title.length == 0) {
            _isHasTitle = NO;
        } else {
            _isHasTitle = YES;
            _titleText = title;
        }
        
        if (actionTitles == nil) {
            _vcViewHeight = 0.0;
        } else {
            _vcViewHeight = cellH * actionTitles.count + kSectionHeaderFooterHeight * 2 + (_isHasTitle ? kTableHeaderHeight : 0);
            self.modalArray = actionTitles;
        }
        
        _cellHeight = cellH;
        _separatorLineWidth = lineWidth;
        _selectStyle = selectStyle;
        
        if (_selectStyle == CSActionSelectStyleCheckmark) {
            _defaultIndex = defaultIndex;
        }

    }
    return self;
}

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
}

#pragma mark - setup subViews

- (void)setupSubViews
{
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.actionTableView];
    
    if (_isHasTitle == YES) {
        self.actionTableView.tableHeaderView = self.titleView;
        self.titleView.titleText = _titleText;
    }
    
//    [self.actionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//    }];
}

#pragma mark - public

- (void)showAlertFromTargetViewController:(UIViewController *)targetViewController
{
    if ((targetViewController == nil) || (_vcViewHeight == 0.0)) {
        return;
    }
    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    [targetViewController presentViewController:self animated:YES completion:nil];
}

- (void)disappearAlert
{
    __weak typeof(self) weakSelf = self;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.alertCDidRemoveBlock) {
            strongSelf.alertCDidRemoveBlock();
        }
    }];
}

#pragma mark - tableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTWActionAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSActionAlertCellID forIndexPath:indexPath];
    
    if (_selectStyle == CSActionSelectStyleCheckmark) {
        if (indexPath.row == _defaultIndex) {
            cell.cheakCell = YES;
        } else {
            cell.cheakCell = NO;
        }
    }
    
    cell.actionText = self.modalArray[indexPath.row];
    cell.bottomLineWidth = _separatorLineWidth;
    cell.showDefaultSelectStyle = (_selectStyle == BTWActionSelectStyleGrey) ? YES : NO;
    if (indexPath.row == (self.modalArray.count - 1)) {
        cell.showBottomLine = NO;
    } else {
        cell.showBottomLine = YES;
    }
    
    return cell;
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSectionHeaderFooterHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kSectionHeaderFooterHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.actionSelectBlock) {
            strongSelf.actionSelectBlock(indexPath.row);
        }
        
        if (strongSelf.alertCDidRemoveBlock) {
            strongSelf.alertCDidRemoveBlock();
        }
    }];
    
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    BTWActionAlertPresentAnimator *presentAnimator = [[BTWActionAlertPresentAnimator alloc] init];
    presentAnimator.vcSize = CGSizeMake(_vcViewWidth, _vcViewHeight);
    return presentAnimator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    BTWActionAlertDismissAnimator *dismissAnimator = [[BTWActionAlertDismissAnimator alloc] init];
    dismissAnimator.vcSize = CGSizeMake(_vcViewWidth, _vcViewHeight);
    return dismissAnimator;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    BTWFormSheetPresentationController *presentationVC = [[BTWFormSheetPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    __weak typeof(self) weakSelf = self;
    
    presentationVC.didTapMaskViewBlock = ^{

        [weakSelf dismissViewControllerAnimated:YES completion:^{
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            if (strongSelf.alertCDidRemoveBlock) {
                strongSelf.alertCDidRemoveBlock();
            }
        }];
    };
    
    return presentationVC;
}

#pragma mark - lazy

- (NSArray *)modalArray {
    if (_modalArray == nil) {
        _modalArray = [NSArray array];
    }
    return _modalArray;
}

- (UITableView *)actionTableView {
    if (_actionTableView == nil) {
        _actionTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _actionTableView.dataSource = self;
        _actionTableView.delegate = self;
        [_actionTableView registerClass:[BTWActionAlertCell class] forCellReuseIdentifier:kCSActionAlertCellID];
        
        _actionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _actionTableView.showsVerticalScrollIndicator = NO;
        _actionTableView.showsHorizontalScrollIndicator = NO;
        _actionTableView.bounces = NO;
        
        _actionTableView.rowHeight = _cellHeight;
        
        _actionTableView.layer.cornerRadius = 8;
        _actionTableView.layer.masksToBounds = YES;
    }
    return _actionTableView;
}

- (BTWActionAlertTitleView *)titleView {
    if (_titleView == nil) {
        _titleView = [[BTWActionAlertTitleView alloc] init];
//        _titleView.height = kTableHeaderHeight;
    }
    return _titleView;
}

@end
