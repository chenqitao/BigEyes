//
//  ImageListViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/14.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "ImageListViewController.h"
#import "ImageModel.h"
#import "ImageTableViewCell.h"
#import "TTdetailViewController.h"
#import "MapViewController.h"
#import "TTSayViewController.h"

@interface ImageListViewController ()<UITableViewDataSource,UITableViewDelegate,DBCameraViewControllerDelegate>
{
    UITableView    *mytableView;
    NSMutableArray *dataSource;   //数据源
    NSInteger      pageno;        //获取List的第几页
    NSInteger      pagesize;      //获取List的个数
    UIButton       *camaraBtn;    //大眼睛拍照按钮
    NSString       *imagePath;    //取得图片的路径
   
   
}

@end

@implementation ImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BigEyes";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(pushmenu)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"map"] style:UIBarButtonItemStylePlain target:self action:@selector(pushmap)];
    dataSource = [[NSMutableArray alloc]init];
   
    // Do any additional setup after loading the view.
}

- (void)createUI {
    mytableView = [UITableView new];
    [self.view addSubview:mytableView];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    mytableView.delaysContentTouches = NO;
    
   //MJRefresh添加，和github上教程不一样
    [mytableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    camaraBtn = [UIButton new];
    [self.view addSubview:camaraBtn];
    [camaraBtn setImage:[UIImage imageNamed:@"cameraBtn"] forState:UIControlStateNormal];
    [camaraBtn bk_whenTapped:^{
        //---------------------------调取相机--------------------------//
        DBCameraContainerViewController *cameraContainer = [[DBCameraContainerViewController alloc] initWithDelegate:self];
        [cameraContainer setFullScreenMode];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraContainer];
        [nav setNavigationBarHidden:YES];
        [self presentViewController:nav animated:YES completion:nil];
       
       
    }];
    [camaraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.bottom.equalTo(self.view).with.offset(20);
        
    }];

}

- (void)refreshData {
    [self createData];
}

- (void)createData {
   
    pageno = 1;
    pagesize = 10;
    [[TTHTTPRequest shareHTTPRequest]openAPIGetToMethod:TTImageListURL parmars:@{@"pageno":[NSNumber numberWithInteger:pageno],@"pagesize":[NSNumber numberWithInteger:pagesize]} success:^(id responseObject) {
        NSArray *arr = responseObject[@"datas"];
         [dataSource removeAllObjects];
        for (NSDictionary *dic in arr) {
        ImageModel  *imageModel = [ImageModel objectWithKeyValues:dic];
        [dataSource addObject:imageModel];
        }
        [mytableView.header endRefreshing];
        [[TMCache sharedCache] setObject:arr forKey:TTImageData block:nil];
        [mytableView reloadData];
       
    } fail:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[TMCache sharedCache] objectForKey:TTImageData]) {
        [dataSource removeAllObjects];
        NSArray *dataArr = [[TMCache sharedCache] objectForKey:TTImageData];
        for (NSDictionary *dic in dataArr) {
            ImageModel  *imageModel = [ImageModel objectWithKeyValues:dic];
            [dataSource addObject:imageModel];
        }
        return dataSource.count;
    } else {
        return dataSource.count;
    }
   
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"cellID";
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.contentView.frame = CGRectMake(0, 0, tableView.frame.size.width, [self tableView:tableView heightForRowAtIndexPath:indexPath]);
        // add a UIButton that you create
    }

    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return (TTScreenWidth+180)/2;
}

- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {

    ImageTableViewCell *imageTableViewCell = (ImageTableViewCell *)cell;
    imageTableViewCell.imagemodel          = dataSource[indexPath.row];
    [imageTableViewCell.backgroundImage sd_setImageWithURL:[NSURL URLWithString:imageTableViewCell.imagemodel.snapurl]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [imageTableViewCell.userImage sd_setImageWithURL:[NSURL URLWithString:imageTableViewCell.imagemodel.userImage] placeholderImage:nil];
    imageTableViewCell.titleLab.text       = imageTableViewCell.imagemodel.subject;
    imageTableViewCell.time.text           = [NSString dateFormaterWithTime:imageTableViewCell.imagemodel.dateline];
    imageTableViewCell.commentBtn.tag      = 7000+indexPath.row;
    [imageTableViewCell.commentBtn bk_whenTapped:^{
        NSLog(@"%ld",imageTableViewCell.commentBtn.tag);
    }];
    [imageTableViewCell.focusBtn bk_whenTapped:^{
        NSLog(@"关注，嘿嘿");
    }];
  
    
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TTdetailViewController *detailVC;
    if (!detailVC) {
        detailVC = [[TTdetailViewController alloc]init];
    }
    detailVC.showNavi = NO;
    detailVC.haveBack = NO;
    ImageModel *imageModel = dataSource[indexPath.row];
    detailVC.detailImageURL = imageModel.snapurl;
    detailVC.tid            = imageModel.tid;
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
}



#pragma mark 弹出menu视图
- (void)pushmap {
    MapViewController *mapVC = [[MapViewController alloc]init];
    mapVC.haveBack = YES;
    mapVC.showNavi = YES;
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark 弹出地图
- (void)pushmenu {
    [self presentLeftMenuViewController:self];

}
#pragma mark 相机代理方法

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata {
    
    //压缩图片
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    //将图片保存在沙盒目录中
    imagePath = [self savetosambox:imageData];
    
    TTSayViewController *sayVC = [[TTSayViewController alloc]init];
    sayVC.showNavi = YES;
    sayVC.haveBack = YES;
    sayVC.holdImagePath= imagePath;
    [self.navigationController pushViewController:sayVC animated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}



- (void) dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}



#pragma mark 保存到沙盒中
- (NSString *)savetosambox:(NSData *)imageData {
    //把图片保存到documents目录中
    NSString *DocumentsPath    = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //把data对象拷贝到沙盒中,并保存为image.png
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *imageName = @"/ypYun.png";
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:imageName] contents:imageData attributes:nil];
    //得到选择后沙盒中图片的完整路径
    NSString  *imagesPath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath,imageName];
    return imagesPath;


}

- (void)viewWillAppear:(BOOL)animated {

    [self.navigationController setNavigationBarHidden:NO];
    [self createData];
}


@end
