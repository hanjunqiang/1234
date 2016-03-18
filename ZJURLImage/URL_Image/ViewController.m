//
//  ViewController.m
//  URL_Image
//
//  Created by 张杰 on 16/2/22.
//  Copyright © 2016年 ZJ. All rights reserved.
//


#import "ViewController.h"

#import "UIImageView+FBI_ImageView.h"

@interface ViewController ()<UITableViewDataSource>

@property (nonatomic, strong) NSArray *urlArr;


@end

@implementation ViewController

- (NSArray *)urlArr
{
    if (!_urlArr) {
        
        _urlArr = @[@"http://www.caos.bg.it/immagini/albero_3.jpg",
                    @"http://1.bp.blogspot.com/-AWQC0Kw9q_Q/Uq8uHsrQkpI/AAAAAAAAFVo/GHOKcf7nrXw/s640/cars.png",
                    @"http://www.german-concept-cars.com/wp-content/uploads/2010/05/German-concept-Cars-Home1.jpg",
                    @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSOUxre9MKwPxFwb89wO33V4PzzCFnZ5ttP6tWmP5YQzRtk_40h",
                    @"http://assets.esquire.co.uk/images/uploads/fourbythree/_540_43/l_236-four-of-the-best-american-muscle-cars-2.jpg",
                    @"http://sportscommunity.com.au/wp-content/uploads/2013/01/sports-collage.jpg",
                    @"http://i.telegraph.co.uk/multimedia/archive/01806/earth_1806334c.jpg",
                    @"https://battlingthedemonswithin.files.wordpress.com/2013/09/earth-cd321c592915ddb9165e20d1053edce9ee78cd3b-s6-c30.jpg",
                    @"http://upload.wikimedia.org/wikipedia/commons/c/cc/2008_Ducati_848_Showroom.jpg",
                    @"http://kickstart.bikeexif.com/wp-content/uploads/2014/01/ducati-999.jpg",
                    @"http://kickstart.bikeexif.com/wp-content/uploads/2012/09/ducati-pantah-2.jpg",
                    @"http://static.derapate.it/derapate/fotogallery/625X0/3775/ducati-999.jpg",
                    @"http://siliconangle.com/files/2012/03/github_logo.jpg",
                    @"https://octodex.github.com/images/octobiwan.jpg",
                    @"https://octodex.github.com/images/murakamicat.png",
                    @"http://tinyurl.com/q7xc48y"];
        
    }
    return _urlArr;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.urlArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSString *url = self.urlArr[indexPath.row];
    UIImage *image = [UIImage imageNamed:@"bw_default_image"];
    cell.imageView.image = image;
    [cell.imageView imageWithURL:url andPlacehodel:image];
    return cell;
}

@end
