//
//  MovieDetailViewController.m
//  DouBan
//
//  Created by 怒煮西兰花 on 15/6/16.
//  Copyright (c) 2015年 蓝鸥科技有限公司. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "DouBanURL.h"
#import "RequestHandle.h"
#import "FileHandle.h"
@interface MovieDetailViewController ()<RequestHandleDelegate>
@property(nonatomic,copy)NSString *detailURL;  //存储拼接完成接口
@property (nonatomic,copy)RequestHandle *handle;
@end

@implementation MovieDetailViewController
//在视图将要出现的时候进行网络请求
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //判断两种情况
    //==nil 说明movie数据不完整需要进行详情数据请求
    // !=nil 说明movie 数据完成 是由本地数据库读取 不许再进行网络请求
    if (self.movie.actors == nil) {
        //请求数据
//        self.handle = [[RequestHandle alloc] initWithURL:_detailURL method:@"GET" parameter:nil delegate:self]; //(这样是错的   为什么????!!!!!)
      [[RequestHandle alloc] initWithURL:_detailURL method:@"GET" parameter:nil delegate:self];
    }
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //请求数据
//    [[RequestHandle alloc] initWithURL:_detailURL method:@"GET" parameter:nil delegate:self];
}
//在视图将要消失的时候取消网络请求
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //取消
    [self.handle cancel];
}
//请求成功
-(void)requestHandle:(RequestHandle *)request didSucceedWithData:(NSData *)data
{
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *movieDic = [dataDic valueForKey:@"result"];
    //对象封装
    [self.movie setValuesForKeysWithDictionary:movieDic];
    
    //刷新数据
    [self reloadData];
}
//请求失败
-(void)requestHandle:(RequestHandle *)request didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
//控件的赋值
-(void)reloadData
{
    self.movie_pic.image = _movie.movie_pic;
    self.rateLabel.text = [_movie.rating stringByAppendingFormat:@"    (%@评论)",_movie.rating_count];
    self.dateLabel.text = _movie.release_date;
    self.runtimeLabel.text = _movie.runtime;
    self.genresLabel.text = _movie.genres;
    self.countryLabel.text = _movie.country;
    self.actorsLabel.text = _movie.actors;
    self.contentLabel.text = _movie.plot_simple;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //添加点击事件 收藏
    [self.saveBt addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self reloadData];
    
}
//收藏事件
- (void)saveAction:(UIButton *)saveBt
{
    //将电影放入数据库
    [[FileHandle shareHandle] insertMovie:self.movie];
}
-(void)setMovie:(Movie *)movie
{
    if (_movie != movie) {
        [_movie release];
        _movie = [movie retain];
        
        //接口拼接
        self.detailURL = [kMovieDetailURL stringByAppendingFormat:@"?movieId=%@",movie.movieId];
        //设置title
        self.navigationItem.title = movie.movieName;
    }
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
    [_rateLabel release];
    [_dateLabel release];
    [_runtimeLabel release];
    [_genresLabel release];
    [_countryLabel release];
    [_actorsLabel release];
    [_contentLabel release];
    [_movie_pic release];
    [super dealloc];
}
@end
