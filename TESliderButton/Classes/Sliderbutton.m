//
//  Sliderbutton.m
//  TESliderButton
//
//  Created by 顾卫明的mac on 2017/12/28.
//

#import "Sliderbutton.h"
#import "UIColorAdditions.h"
@implementation Sliderbutton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.partRectArray = [NSMutableArray array];
        self.numberOfPart = 5;
        self.sliderBarHeight = 10;
        self.textUnitFont = 13;
        self.textUnitColor = @"#000000";
        self.thumbSize = CGSizeMake(self.sliderBarHeight, self.sliderBarHeight);
        self.partSize = self.thumbSize;
        self.ButtonRadius = 15;
        self.indexvalue = 0;
        self.ButtonColor = @"#ff0000";
        self.ButtonText = @"8M";
    }
    return self;
}

//节点必须>1
- (void)setNumberOfPart:(NSInteger)numberOfPart {
    _numberOfPart = numberOfPart > 1 ? numberOfPart: 2;
}

//重绘
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画slider
    [self loadSliderWithContext:context];
    
    //画滑块
    [self loadThumWithContext:context];
    
    //    self.backgroundColor = [UIColor colorWithHex:self.bgcolor];
}

//画滑块
- (void)loadThumWithContext:(CGContextRef)context {
    
    //当前滑块
    if (!self.isFirst) {
        //滑块初始化
        self.thumbRect = [self.partRectArray[self.indexvalue] CGRectValue];
        self.isFirst = YES;
    }
    
    //有背景图则用背景图 没有就画圆
    CGContextSetFillColorWithColor(context, [UIColor colorWithHex:self.ButtonColor].CGColor);//填充颜色
    CGContextSetLineWidth(context, 0);//线的宽度
    CGContextAddArc(context, self.thumbRect.origin.x, self.thumbRect.origin.y, self.ButtonRadius, 0, 2*M_PI, 0); //添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(context, kCGPathFillStroke);
    
    NSString *string = self.ButtonText;
    UIFont *fount = [UIFont systemFontOfSize:self.textUnitFont];
    CGContextSetFillColorWithColor(context, [UIColor colorWithHex:self.textUnitColor].CGColor);
    [string drawInRect:CGRectMake(self.thumbRect.origin.x-15, self.thumbRect.origin.y-7.5,30,30)withFont:fount lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
}

//画滑杆内容
- (void)loadSliderWithContext:(CGContextRef)context {
    //设置滑杆的frame
    CGFloat tmp = self.thumbSize.width > self.partSize.width ? self.thumbSize.width :  self.partSize.width;
    CGFloat tmpHeight = self.thumbSize.height > self.partSize.height ? self.thumbSize.height :  self.partSize.height;
    
    CGFloat sliderHeight = self.sliderBarHeight;
    CGFloat sliderMargin = 10 + tmp/2;
    CGFloat sliderY = CGRectGetHeight(self.frame)/2;
    CGFloat sliderWidth = CGRectGetWidth(self.frame) - 2 * sliderMargin - tmp;
    self.sliderRect = CGRectMake(sliderMargin + self.partSize.width/2, sliderY-tmpHeight/2, sliderWidth+tmp, tmpHeight);
    
    
    //画slider滑杆（小圆点）
    CGPoint starPoint = CGPointMake(sliderMargin + tmp/2, sliderY);
    CGFloat y = CGRectGetHeight(self.frame)/2 -self.thumbSize.height/2;
    for (int i = 0; i < self.numberOfPart-1; i++) {
        for (int j=0; j<self.numberOfPart; j++) {
            CGFloat x = i * sliderWidth/(self.numberOfPart-1) + starPoint.x-self.thumbSize.width/2 + sliderWidth/(self.numberOfPart-1)*j/self.numberOfPart;
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
            CGContextSetLineWidth(context, 0);//线的宽度
            
            CGContextAddArc(context, x+2, y+self.sliderBarHeight/2+1, 1, 0, 2*M_PI, 0); //添加一个圆
            
            CGContextDrawPath(context, kCGPathFillStroke);
        }
    }
    //画分段点(中圆点，大圆点)
    [self.partRectArray removeAllObjects];
    
    for (int i = 0; i < self.numberOfPart; i++) {
        CGFloat x = i * sliderWidth/(self.numberOfPart-1) + starPoint.x;
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);//填充颜色
        CGContextSetLineWidth(context, 0);//线的宽度
        if(i==0 || i==self.numberOfPart - 1){
            CGContextAddArc(context, x, y+5, 10, 0, 2*M_PI, 0); //添加一个圆
        }else{
            CGContextAddArc(context, x, y+self.sliderBarHeight/2+1, 4, 0, 2*M_PI, 0); //添加一个圆
        }
        //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
        CGContextDrawPath(context, kCGPathFillStroke);
        //计算滑块位置
        CGRect fram = CGRectMake(x, y+5, self.thumbSize.width, self.thumbSize.height);
        
        [self.partRectArray addObject:[NSValue valueWithCGRect:fram]];
    }
}
//开始拖动
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    //可滑动范围 写了的话 滑动范围很小
    //    if (!CGRectContainsPoint(self.sliderRect, point)) {
    //        return NO;
    //    }
    int index = [self getCurrentXWithOffset:point.x];
    self.thumbRect = [self.partRectArray[index] CGRectValue];
    [self setNeedsDisplay];
    return YES;
    
}


//持续拖动
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    CGFloat thumbImageX = point.x - self.thumbSize.width/2;
    if (thumbImageX > [self.partRectArray[0] CGRectValue].origin.x && thumbImageX<[self.partRectArray[self.numberOfPart-1] CGRectValue].origin.x) {
        self.thumbRect = CGRectMake(thumbImageX, self.thumbRect.origin.y, self.thumbRect.size.width, self.thumbRect.size.height);
        [self setNeedsDisplay];
        int index = [self getCurrentXWithOffset:point.x];
        if(index >= 0 && index <= self.numberOfPart-1){
            //增加控制事件
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
    return YES;
}

//拖动结束
- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    int index = [self getCurrentXWithOffset:point.x];
    if(index >= 0 && index <= self.numberOfPart-1){
        self.thumbRect = [self.partRectArray[index] CGRectValue];
        [self setNeedsDisplay];
        //增加控制事件
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

//计算滑到一半时根据占比选择对应位置
- (int)getCurrentXWithOffset:(CGFloat)x {
    CGFloat tmpX = x - [self.partRectArray[0] CGRectValue].origin.x;
    //超出边界
    if (tmpX > [self.partRectArray[self.numberOfPart-1] CGRectValue].origin.x) {
        tmpX = [self.partRectArray[self.numberOfPart-1] CGRectValue].origin.x;
    }
    
    //计算总长度
    CGFloat firstx = [[self.partRectArray firstObject] CGRectValue].origin.x;
    CGFloat lastx = [[self.partRectArray lastObject] CGRectValue].origin.x;
    CGFloat wid = lastx - firstx;
    CGFloat part = wid/(self.numberOfPart-1) ;
    //减去滑块占比
    //    CGFloat per = self.thumbSize.width/2/part;
    
    int count = tmpX / part;
    if (count <= 0) {
        count = 0;
        
    }
    if (count>=self.numberOfPart-1) {
        count = count;
    }
    self.value = count;
    return count;
}

@end

