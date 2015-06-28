//
//  ActivityListViewController.m
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "ActivityListViewController.h"
#import "activityCell.h"
#import "ActivityViewController.h"
#import "Activity.h"
#import "RequestHandle.h"
#import "DouBanURL.h"
@interface ActivityListViewController ()<RequestHandleDelegate>

@property (nonatomic,retain)NSMutableArray *activityArr;

@end

@implementation ActivityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //请求数据
    [self requestData];
}
//请求数据
-(void)requestData
{
    [[RequestHandle alloc] initWithURL:kActivityListURL method:@"GET" parameter:nil delegate:self];
    
}
//请求成功
-(void)requestHandle:(RequestHandle *)request didSucceedWithData:(NSData *)data
{
    //数据解析
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *dataArr = [dataDic valueForKey:@"events"];
    
    //遍历数组获取 movie
    for (NSDictionary *ActivityDic in dataArr) {
        //封装对象
        Activity *activity = [[Activity alloc] init];
        //KVC赋值
        [activity setValuesForKeysWithDictionary:ActivityDic];
        //将对象放入数组中
        if (_activityArr == nil) {
            self.activityArr = [NSMutableArray array];
        }
        [_activityArr addObject:activity];
        [activity release];
    }
    
    //刷新数据
    [self.tableView reloadData];
}
//请求失败
-(void)requestHandle:(RequestHandle *)request didFailWithError:(NSError *)error
{
//    NSLog(@"%@",error);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _activityArr.count;
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //获取对应的电影
    Activity *activity = self.activityArr[indexPath.row];

    //赋值
    cell.titleLabel.text = activity.title;
    cell.timeLabel.text = activity.time;
    cell.addressLabel.text = activity.address;
    cell.typeLable.text = activity.category_name;
    cell.interestedLable.text = activity.wisher_count;
    cell.attendLable.text = activity.participant_count;
    if(activity.activity_pic == nil && activity.isLoading == NO){
        //图片下载
        [activity loadImage];
        //添加观察者
        [activity addObserver:self forKeyPath:@"activity_pic" options:NSKeyValueObservingOptionNew context:[indexPath retain]];
    }else{
        cell.activityImage.image = activity.activity_pic;
    }
    return cell;
}
//KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    NSIndexPath *indexPath = (NSIndexPath *)context;
    //获取cell
    ActivityCell *cell = (ActivityCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",[change valueForKey:@"new"]);
    //赋值
    cell.activityImage.image = [change valueForKey:@"new"];
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityViewController *detailVC = [[ActivityViewController alloc] init] ;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    //属性传值
    //获取对应movie对象
    Activity *activity = self.activityArr[indexPath.row];
    detailVC.activity = activity;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
