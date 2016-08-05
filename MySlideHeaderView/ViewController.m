//
//  ViewController.m
//  MySlideHeaderView
//
//  Created by 昕明 刚 on 16/8/5.
//  Copyright © 2016年 brain. All rights reserved.
//

#import "ViewController.h"
#import "SlideHeaderView.h"


@interface ViewController () <UITableViewDelegate,UITableViewDataSource,SlideHeaderViewDelegate> {
    UITableView *myTableView;
    SlideHeaderView *slideHeaderView;
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
    slideHeaderView = [SlideHeaderView slideHeaderViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) delegate:self];
    
    
    
    myTableView.tableHeaderView = slideHeaderView;
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tableView delegate
/**
 *  tableView delegate
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStr = @"testTableViewCell";
    
    UITableViewCell *testCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (!testCell) {
        testCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    
    testCell.textLabel.text = @"test";
    
    testCell.backgroundColor = [UIColor whiteColor];
    return testCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //一定要在scrollView代理调用这个方法  否则不会有滑动效果
    [slideHeaderView getScrollViewContentOffSet:scrollView.contentOffset.y];
}

@end
