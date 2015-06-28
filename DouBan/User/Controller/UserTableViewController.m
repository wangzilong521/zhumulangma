//
//  UserTableViewController.m
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "UserTableViewController.h"
#import "CollectTableViewController.h"
#import "FileHandle.h"
@interface UserTableViewController ()

@property (nonatomic,retain)NSArray *titleArr;

@end

@implementation UserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"我的活动",@"我的电影",@"清除缓存"];
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectTableViewController *collectVC = [[[CollectTableViewController alloc] init] autorelease];
    
    //获取cell
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.textLabel.text isEqualToString:@"我的活动"]) {
        //push  进入活动查询
        //给收藏界面传入活动数组进行展示
        [self.navigationController pushViewController:collectVC animated:YES];
        
    }else if([cell.textLabel.text isEqualToString:@"我的电影"])
    {
        //push 进入电影查询
        //给收藏界面传入电影数组进行展示
        [self.navigationController pushViewController:collectVC animated:YES];
        collectVC.dataArr = [[FileHandle shareHandle] selectMovieNames];
        
    }else if([cell.textLabel.text isEqualToString:@"清除缓存"])
    {
        //清除缓存操作
        //获取图片存在的文件路径
        NSString *imageDownLoaderPath = [[FileHandle shareHandle] getImageDownLoadFilePath];
        
        //2.创建文件管理对象
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //3.删除
        [manager removeItemAtPath:imageDownLoaderPath error:nil];
        
        //获取数据库存在的文件路径
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
        NSString *dbPath = [caches stringByAppendingString:@"/db.sqlite"];
        //删除
        [manager removeItemAtPath:dbPath error:nil];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
