//
//  ActivityViewController.m
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "ActivityViewController.h"
#import "FileHandle.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //添加点击事件 收藏
    [self.saveBt addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    //刷新数据
    [self reloadData];
}
//收藏事件
- (void)saveAction:(UIButton *)saveBt
{
    //将电影放入数据库
    [[FileHandle shareHandle] insertMovie:self.activity];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
//控件的赋值
-(void)reloadData
{
    self.activityImage.image = _activity.activity_pic;
    self.navigationItem.title = _activity.title;
    self.titleLable.text = _activity.title;
    self.timeLabel.text = _activity.time;
    self.nameLable.text = _activity.ownerName;
    self.typeLabel.text = _activity.category_name;
    self.addressLabel.text = _activity.address;
    self.detailLabel.text = _activity.content;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_titleLable release];
    [_timeLabel release];
    [_nameLable release];
    [_typeLabel release];
    [_addressLabel release];
    [_activityImage release];
    [_detailLabel release];
    [super dealloc];
}
@end
