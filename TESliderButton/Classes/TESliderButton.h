//
//  TESliderButton.h
//  TESliderButton
//
//  Created by 顾卫明的mac on 2017/12/28.
//

#import <UIKit/UIKit.h>

@interface TESliderButton : UIView
//当前值
@property (nonatomic,assign)NSInteger value;
//选择点个数 >2
@property (nonatomic,assign)NSInteger numberOfPart;
//当前滑块颜色
@property (nonatomic,assign)UIColor *thumbColor;
//当前滑块尺寸
@property (nonatomic,assign)CGSize thumbSize;
//分段点尺寸
@property (nonatomic,assign)CGSize partSize;
//slider height
@property (nonatomic,assign)CGFloat sliderBarHeight;
//分段点的颜色
@property (nonatomic,assign)UIColor *partColor;
//slider 滑竿颜色
@property (nonatomic,assign)UIColor *sliderColor;

@property(nonatomic,assign)CGRect thumbRect;    //滑块fram
@property(nonatomic,assign)CGRect sliderRect;   //sliderFrame
@property(nonatomic,strong)NSMutableArray *partRectArray; //节点frame数组
@property(nonatomic,assign)BOOL isFirst;        //首次运行
@property (nonatomic,copy) NSString *textUnitColor;//设置字体颜色

@property (nonatomic, assign) CGFloat textUnitFont;
@property (nonatomic, assign) NSInteger indexvalue;
@property (nonatomic, copy) NSString *ButtonText;
@property (nonatomic, assign) CGFloat ButtonRadius;
@property (nonatomic, copy) NSString *ButtonColor;
@end
