//
//  MovieListViewController.m
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#define kMovie @"http://api.dianping.com/v1/deal/find_deals?appkey=42960815&sign=34691B2D691C0C23FA8AE643DF3178E508250585&city=%E4%B8%8A%E6%B5%B7&category=%E7%BE%8E%E9%A3%9F&limit=30&page=1"

#import "MovieListViewController.h"
#import "RequestHandle.h"
#import "Movie.h"
#import "DouBanURL.h"
#import "MovieTableCell.h"
#import "MovieDetailViewController.h"
@interface MovieListViewController ()<RequestHandleDelegate>
@property(nonatomic,retain)NSMutableArray *movieArr;
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieTableCell" bundle:nil] forCellReuseIdentifier:@"movieCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //请求数据
    [self requestData];
}
//请求数据
-(void)requestData
{
    [[RequestHandle alloc] initWithURL:kMovieListURL method:@"GET" parameter:nil delegate:self];
    
}
//请求成功
-(void)requestHandle:(RequestHandle *)request didSucceedWithData:(NSData *)data
{
    //数据解析
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *dataArr = [dataDic valueForKey:@"result"];
    
    //遍历数组获取 movie
    for (NSDictionary *movieDic in dataArr) {
        //封装对象
        Movie *movie = [[Movie alloc] init];
        //KVC赋值
        [movie setValuesForKeysWithDictionary:movieDic];
        //将对象放入数组中
        if (_movieArr == nil) {
            self.movieArr = [NSMutableArray array];
        }
        [_movieArr addObject:movie];
        [movie release];
    }
   
    //刷新数据
    [self.tableView reloadData];
}
//请求失败
-(void)requestHandle:(RequestHandle *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - DataSource Delegate
//分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _movieArr.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    cell.movie_pic.image = [UIImage imageNamed:@"picholder.png"];
    //获取对应的电影
    Movie *movie = self.movieArr[indexPath.row];
    
    //赋值
    cell.movie_name.text = movie.movieName;
    if(movie.movie_pic == nil && movie.isLoading == NO){
        //图片下载
        [movie loadImage];
        //添加观察者
        [movie addObserver:self forKeyPath:@"movie_pic" options:NSKeyValueObservingOptionNew context:[indexPath retain]];
    }else{
        cell.movie_pic.image = movie.movie_pic;
    }
    return cell;
}
//KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    NSIndexPath *indexPath = (NSIndexPath *)context;
    //获取cell
    MovieTableCell *cell = (MovieTableCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    //赋值
    cell.movie_pic.image = [change valueForKey:@"new"];
}
//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 160;
}
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建下一个视图控制器对象
    MovieDetailViewController *detailVC = [[MovieDetailViewController alloc] init];
    //push操作
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
    
    //属性传值
    //获取对应movie对象
    Movie *movie = self.movieArr[indexPath.row];
    detailVC.movie = movie;
    
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
