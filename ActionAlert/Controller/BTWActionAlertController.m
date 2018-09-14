

#import "BTWActionAlertController.h"

#import "BTWActionAlertCell.h"
//#import <Masonry.h>

static CGFloat const kHasTitleCellHeight = 48;
static CGFloat const kNoTitleCellHeight = 44;

static CGFloat const kHasTitleVCWidth = 355;
static CGFloat const kNoTitleVCWidth = 280;

static CGFloat const kTableViewTopBottomInset = 10;

static CGFloat const kHasSeparatorLineWidth = 315;
static CGFloat const kNoSeparatorLineWidth = 280;

static NSString * const kCSActionAlertCellID = @"kCSActionAlertCellID";

@interface BTWActionAlertController () <UITableViewDataSource, UITableViewDelegate>
{
    CGFloat _vcViewWidth;
    CGFloat _vcViewHeight;
    CGFloat _cellHeight;
    UIEdgeInsets _tableViewEdgeInsets;
    CGFloat _separatorLineWidth;
    BTWActionSelectStyle _selectStyle;
}

@property (nonatomic, strong) UITableView *actionTableView;

@property (nonatomic, strong) NSArray *modalArray;

@end

@implementation BTWActionAlertController

- (void)dealloc
{
    
}

#pragma mark - init

- (instancetype)initWithActionTitleArray:(NSArray<NSString *> *)actionTitles actionSelectStyle:(BTWActionSelectStyle)selectStyle
{
    if (self = [self initWithTitle:nil actionTitleArray:actionTitles actionCellHeight:kNoTitleCellHeight tableViewInsets:UIEdgeInsetsMake(kTableViewTopBottomInset, 0, kTableViewTopBottomInset, 0) separatorLineWidth:kNoSeparatorLineWidth actionSelectStyle:selectStyle]) {
        _vcViewWidth = kNoTitleVCWidth;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title actionTitleArray:(NSArray<NSString *> *)actionTitles actionSelectStyle:(BTWActionSelectStyle)selectStyle
{
    if (self = [self initWithTitle:title actionTitleArray:actionTitles actionCellHeight:kHasTitleCellHeight tableViewInsets:UIEdgeInsetsMake(kFormSheetNavigationBarHeight + kTableViewTopBottomInset, 0, kTableViewTopBottomInset, 0) separatorLineWidth:kHasSeparatorLineWidth actionSelectStyle:selectStyle]) {
        _vcViewWidth = kHasTitleVCWidth;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title actionTitleArray:(NSArray<NSString *> *)actionTitles actionCellHeight:(CGFloat)cellH tableViewInsets:(UIEdgeInsets)insets separatorLineWidth:(CGFloat)lineWidth actionSelectStyle:(BTWActionSelectStyle)selectStyle
{
    if (self = [super init]) {
        
        if (title.length == 0) {
            self.formSheetNaviBar.hidden = YES;
            _tableViewEdgeInsets = insets;
        } else {
            self.formSheetNaviBar.hidden = NO;
            self.formSheetNaviBar.titleLabel.text = title;
        }
        
        if (actionTitles == nil) {
            _vcViewHeight = 0;
        } else {
            _vcViewHeight = cellH * actionTitles.count + insets.top + insets.bottom;
            self.modalArray = actionTitles;
        }
        _cellHeight = cellH;
        _tableViewEdgeInsets = insets;
        _separatorLineWidth = lineWidth;
        _selectStyle = selectStyle;
    }
    return self;
}

#pragma mark - show alert

- (void)showAlert
{
    [self addToWindowRootViewControllerWithViewSize:CGSizeMake(_vcViewWidth, _vcViewHeight)];
}

- (void)removeAlert
{
    [self removeFromWindowRootViewController];
    
    if (self.alertCDidRemoveBlock) {
        self.alertCDidRemoveBlock();
    }
}

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - setup subViews

- (void)setupSubViews
{
    [self.view addSubview:self.actionTableView];
//    [self.actionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_offset(_tableViewEdgeInsets);
//    }];
}

#pragma mark - tableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modalArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTWActionAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSActionAlertCellID forIndexPath:indexPath];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeAlert];
    
    if (self.actionSelectBlock) {
        self.actionSelectBlock(indexPath.row);
    }
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
        _actionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _actionTableView.showsVerticalScrollIndicator = NO;
        [_actionTableView registerClass:[BTWActionAlertCell class] forCellReuseIdentifier:kCSActionAlertCellID];
    }
    return _actionTableView;
}

@end
