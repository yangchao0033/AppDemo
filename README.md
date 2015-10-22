# BiSheStatus
修改大多数bug，并完善所有主要功能


#动画时间控制


`CAMediaTiming`协议，是被`CAAnimation`以及其子类`CABasicAnimation`和`CAKeyframeAnimation`所实现的。所有和时间相关的属性都来自于他，比如-----`duration`, `beginTime` 和 `repeatCount` 。总的来说，这个协议定义了八个属性，他们之间互相组合可以产生一系列的精确清晰的时间方案。

##Visualizing CAMediaTiming

为了说明不同的时间相关属性，包括他们自己和他们之间组合的方案。我创建了一个橘色到蓝色的颜色动画。方块展示了从开始到结束的进度，中间的分割线是一秒钟一格。你可以通过时间线上的分割线来观察在动画中第x秒时变化为何种颜色。比如，下面很形象的描述了动画时间间隔`duration`。


时间间隔被设置为1.5秒

<figure>
<code>
duration=1.5
</code>
<div role="img" aria-label="Setting the duration to 1.5 seconds makes the animation take 1.5 seconds" style="margin-bottom: 30%;">
<div style="margin: auto; width: 100%; height: 0px;">
<svg class="autoscaled-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 470 73" width="100%">
    <defs>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-1">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="#4aa5e3" offset="100%"></stop>
        </linearGradient>
    </defs>
    <g stroke="#222F39" stroke-width="2" fill="none">
        <rect d="M1,1 L1,73 L469,73 L469,1 L1,1 Z M0,0" x="0" y="0" width="470" height="73"></rect>
        <path d="M118.5,0 L118.5,74"></path>
        <path d="M236.5,0 L236.5,74"></path>
        <path d="M352.5,0 L352.5,74"></path>
    </g>
    <rect id="path-2" x="4" y="4" width="175" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
</svg>
</div>
</div>
</figure>

默认情况下`CAAnimations`会在执行完毕后从`layer`上移除。也就是说一旦`layer`的颜色变成了橘色（初始值），动画结束后，颜色又会变回到橘色。


假如我们让动画的`beginTime`也可见，那么如图所示：
<figure>
<code>
duration=1.5, beginTime=1.0
</code>
<div role="img" aria-label="Setting the duration to 1.5 seconds and begin time to 1.0 makes the animation end after 2.5 seconds" style="margin-bottom: 30%;">
<div style="margin: auto; width: 100%; height: 0px;">
<svg class="autoscaled-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 470 73" width="100%">
    <defs>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-1">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="#4aa5e3" offset="100%"></stop>
        </linearGradient>
    </defs>
    <g stroke="#222F39" stroke-width="2" fill="none">
        <rect d="M1,1 L1,73 L469,73 L469,1 L1,1 Z M0,0" x="0" y="0" width="470" height="73"></rect>
        <path d="M118.5,0 L118.5,74"></path>
        <path d="M236.5,0 L236.5,74"></path>
        <path d="M352.5,0 L352.5,74"></path>
    </g>
    <rect id="path-2" x="120" y="4" width="175" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
</svg>
</div>
</div>
</figure>


设置时间间隔为1.5并且开始时间为1.0s持续时间设置为1.5秒，并且开始时间设置为当前时间 (`CACurrentMediaTime()`) 加1秒， 所以动画会在1.5秒后结束，再动画被加到`layer`之后，会花费1秒后开始执行动画的开始，并且使动画可见，时间加起来刚好是1+1.5=2.5.

为了在动画开始之前得到动画的`fromValue`(或者设置可用的`beginTime`之前)，你可以配置`mode`为`fill backwards mode`，通过设置`fillMode`为`kCAFillModeBackwards`。(简单讲，就是让动画在添加到`layer`上时，在`start Value`之前就开始执行动画)

<figure>
<code>
duration=1.5, beginTime=1.0, fillMode=back
</code>
<div role="img" aria-label="Fill mode can be used to display the fromValue before the animation starts" style="margin-bottom: 30%;">
<div style="margin: auto; width: 100%; height: 0px;">
<svg class="autoscaled-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 470 73" width="100%">
    <defs>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-1">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="#4aa5e3" offset="100%"></stop>
        </linearGradient>
    </defs>
    <g stroke="#222F39" stroke-width="2" fill="none">
        <rect d="M1,1 L1,73 L469,73 L469,1 L1,1 Z M0,0" x="0" y="0" width="470" height="73"></rect>
        <path d="M118.5,0 L118.5,74"></path>
        <path d="M236.5,0 L236.5,74"></path>
        <path d="M352.5,0 L352.5,74"></path>
    </g>
    <rect id="path-2" x="4" y="4" width="120" height="65" stroke="none" fill="#ffb900"></rect>
    <rect id="path-2" x="120" y="4" width="175" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
</svg>
</div>
</div>
</figure>

`Fill mode`被用来在动画开始之前显示动画的起始值。`autoreverses`自动翻转属性会引起动画从`start value`开始执行到`end value`结束后，又以相反的路径执行动画直到回到`start value`状态.这将意味着这个属性会引起动画执行时间变为原来的两倍。

<figure>
<code>
duration=1.5, autoreverses
</code>
<div role="img" aria-label="Autoreverses makes the animation return to the start after reaching the end" style="margin-bottom: 30%;">
<div style="margin: auto; width: 100%; height: 0px;">
<svg class="autoscaled-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 470 73" width="100%">
    <defs>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-1">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="#4aa5e3" offset="100%"></stop>
        </linearGradient>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-2">
            <stop stop-color="#4aa5e3" offset="0%"></stop>
            <stop stop-color="#ffb900" offset="100%"></stop>
        </linearGradient>
    </defs>
    <g stroke="#222F39" stroke-width="2" fill="none">
        <rect d="M1,1 L1,73 L469,73 L469,1 L1,1 Z M0,0" x="0" y="0" width="470" height="73"></rect>
        <path d="M118.5,0 L118.5,74"></path>
        <path d="M236.5,0 L236.5,74"></path>
        <path d="M352.5,0 L352.5,74"></path>
    </g>
    <rect id="path-2" x="4" y="4" width="175" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
    <rect id="path-2" x="178" y="4" width="173" height="65" stroke="none" fill="url(#linearGradient-2)"></rect>
</svg>
</div>
</div>
</figure>

`Autoreverses`可以是动画在执行结束后又以动画的形式回到初始状态，与它相比，`repeatCount`是用来指定动画的执行次数为两次或者任何你指定的次数(你也可以设置分级的重复次数，比如1.5次就是1.5次动画)。一旦动画到达他的终值后就立即跳回到初始值的地方在重新开始执行。

<figure>
<code>
duration=1.5, repeatCount=2.0
</code>
<div role="img" aria-label="Repeat count causes the animation to run more than once" style="margin-bottom: 30%;">
<div style="margin: auto; width: 100%; height: 0px;">
<svg class="autoscaled-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 470 73" width="100%">
    <defs>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-1">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="#4aa5e3" offset="100%"></stop>
        </linearGradient>
    </defs>
    <g stroke="#222F39" stroke-width="2" fill="none">
        <rect d="M1,1 L1,73 L469,73 L469,1 L1,1 Z M0,0" x="0" y="0" width="470" height="73"></rect>
        <path d="M118.5,0 L118.5,74"></path>
        <path d="M236.5,0 L236.5,74"></path>
        <path d="M352.5,0 L352.5,74"></path>
    </g>
    <rect id="path-2" x="4" y="4" width="175" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
    <rect id="path-2" x="178" y="4" width="173" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
</svg>
</div>
</div>
</figure>
`Repeat count` 会让动画执行多次

类似于`Repeat count`但是真的很少用到的属性---`repeat duration`.它只是简单的在给定的一段持续时间内重复动画(如下图所示2秒)，如果传入的这段时间间隔（`repeat duration`）少于动画执行的时间时，将会引起动画的提前结束__(即在`repeat duration`过后结束)__
<figure>
<code>
duration=1.5, repeatDuration=2.0
</code>
<div role="img" aria-label="Repeat count causes the animation to run more than once" style="margin-bottom: 30%;">
<div style="margin: auto; width: 100%; height: 0px;">
<svg class="autoscaled-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 470 73" width="100%">
    <defs>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-1">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="#4aa5e3" offset="100%"></stop>
        </linearGradient>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-2a">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="rgb(172,176,125)" offset="100%"></stop>
        </linearGradient>
    </defs>
    <g stroke="#222F39" stroke-width="2" fill="none">
        <rect d="M1,1 L1,73 L469,73 L469,1 L1,1 Z M0,0" x="0" y="0" width="470" height="73"></rect>
        <path d="M118.5,0 L118.5,74"></path>
        <path d="M236.5,0 L236.5,74"></path>
        <path d="M352.5,0 L352.5,74"></path>
    </g>
    <rect id="path-2" x="4" y="4" width="175" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
    <rect id="path-2" x="179" y="4" width="58" height="65" stroke="none" fill="url(#linearGradient-2a)"></rect>
</svg>
</div>
</div>
</figure>

`Repeat duration`会让动画在给定的时间内重复执行

这些属性都是可以进行组合来实现不同的动画效果.

<figure>
<code>
duration=0.5, repeatCount=2.5, autoreverses
</code>
<div role="img" aria-label="Repeat count causes the animation to run more than once" style="margin-bottom: 30%;">
<div style="margin: auto; width: 100%; height: 0px;">
<svg class="autoscaled-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 470 73" width="100%">
    <defs>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-1">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="#4aa5e3" offset="100%"></stop>
        </linearGradient>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-2">
            <stop stop-color="#4aa5e3" offset="0%"></stop>
            <stop stop-color="#ffb900" offset="100%"></stop>
        </linearGradient>
    </defs>
    <g stroke="#222F39" stroke-width="2" fill="none">
        <rect d="M1,1 L1,73 L469,73 L469,1 L1,1 Z M0,0" x="0" y="0" width="470" height="73"></rect>
        <path d="M118.5,0 L118.5,74"></path>
        <path d="M236.5,0 L236.5,74"></path>
        <path d="M352.5,0 L352.5,74"></path>
    </g>
    <rect id="path-2" x="4" y="4" width="58" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
    <rect id="path-2" x="62" y="4" width="58" height="65" stroke="none" fill="url(#linearGradient-2)"></rect>
    
    <rect id="path-2" x="119" y="4" width="58" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
    <rect id="path-2" x="177" y="4" width="58" height="65" stroke="none" fill="url(#linearGradient-2)"></rect>
  
    <rect id="path-2" x="234" y="4" width="58" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
</svg>
</div>
</div>
</figure>

他们都可以进行混合

其中一个更有趣的相关属性是`speed`,通过设置`duration`间隔为3s,速度为2,动画效果会很明显的执行一次只需要1.5s，应为他会比之前的的速度快两倍.

<figure>
<code>
duration=3.0, speed=2.0
</code>
<div role="img" aria-label="Setting the duration to 1.5 seconds makes the animation take 1.5 seconds" style="margin-bottom: 30%;">
<div style="margin: auto; width: 100%; height: 0px;">
<svg class="autoscaled-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 470 73" width="100%">
    <defs>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-1">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="#4aa5e3" offset="100%"></stop>
        </linearGradient>
    </defs>
    <g stroke="#222F39" stroke-width="2" fill="none">
        <rect d="M1,1 L1,73 L469,73 L469,1 L1,1 Z M0,0" x="0" y="0" width="470" height="73"></rect>
        <path d="M118.5,0 L118.5,74"></path>
        <path d="M236.5,0 L236.5,74"></path>
        <path d="M352.5,0 L352.5,74"></path>
    </g>
    <rect id="path-2" x="4" y="4" width="175" height="65" stroke="none" fill="url(#linearGradient-1)"></rect>
</svg>
</div>
</div>
</figure>

两倍的速度会使动画在三秒内走两次，也就是只需花1.5s就执行完毕一次.
如果只是配置一个简单的动画，你仅仅只需要分配起始时间`beginTime`和持续间隔`duration`来得到与上述相同的结果,`speed`属性的能力来自于两个事实:

动画速度是分等级的，`CAAnimation`不是实现`CAMediaTiming`速度分级的为一类.

一个`speed`为1.5的动画,并且是一个`speed`为2的动画组的一部分，则这部分动画将会有效运行为原来3倍快.

Other implementations of CAMediaTiming
`CAMediaTiming`的其他实现

`CAMediaTiming`是一个协议，不仅`CAAnimation`,同样`CALayer`也有对他相关的实现，这将意味着你可以设置一个图层的`speed`为2.0,并且所有的在这个`layer`上加上的所有动画都会执行2倍快.并且仍然遵守时间分级制度,`speed`为0.5的`layer`加上`spped`为0.5的动画，将会以正常速度的1.5倍运行.

控制一个动画或`layer`的`speed`同样也可以设置`speed`为0来暂停动画.同样`timeOffset`可以通过一个类似于滑块的外部装置来控制动画是否需要在整个过程中延时执行.

`timeOffset`属性起初非常奇怪,如同它的名词解释，它能使时间偏移，通常被用作计算动画的状态.这是最形象化的.下面是3s的时间间隔和1s的偏移量：
<figure>
<code>
duration=3.0, timeOffset=1.0
</code>
<div role="img" aria-label="Repeat count causes the animation to run more than once" style="margin-bottom: 30%;">
<div style="margin: auto; width: 100%; height: 0px;">
<svg class="autoscaled-svg" xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 470 73" width="100%">
    <defs>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-4">
            <stop stop-color="rgb(196,179,97)" offset="0%"></stop>
            <stop stop-color="#4aa5e3" offset="100%"></stop>
        </linearGradient>
        <linearGradient x1="0%" y1="50%" x2="100%" y2="50%" id="linearGradient-5">
            <stop stop-color="#ffb900" offset="0%"></stop>
            <stop stop-color="rgb(196,179,97)" offset="100%"></stop>
        </linearGradient>
    </defs>
    <g stroke="#222F39" stroke-width="2" fill="none">
        <rect d="M1,1 L1,73 L469,73 L469,1 L1,1 Z M0,0" x="0" y="0" width="470" height="73"></rect>
        <path d="M118.5,0 L118.5,74"></path>
        <path d="M236.5,0 L236.5,74"></path>
        <path d="M352.5,0 L352.5,74"></path>
    </g>
    <rect id="path-2" x="4" y="4" width="233" height="65" stroke="none" fill="url(#linearGradient-4)"></rect>
<rect id="path-2" x="237" y="4" width="115" height="65" stroke="none" fill="url(#linearGradient-5)"></rect>

</svg>
</div>
</div>
</figure>

你可以`offset`整个动画,但是他将会运行完所有部分.

动画会瞬间开始并关闭一秒内的从橘色到蓝色的转场过渡（还没有变为蓝色）.之后运行剩余的两秒直到完全变蓝,然后完全跳回到第一秒内的颜色过渡转场。整个过程就像我们吧第一秒内的动画剪切掉，并把它追加到了整个动画的最后.

This property in itself has almost no use but it can be combined with a paused animation (speed = 0) to control the “current time”. A paused animation is stuck at the first frame. If you look at the very first color in the offset animation (above) you can see that it’s the color value one second into the color transition. By setting the time offset to another value you get that time into the transition.

If you want more of these timing illustrations, I made a little cheat sheet.

Controlling animation timing

Used together, speed and timeOffset can control the current “time” of an animation. There is almost no code involved but the concept can be tricky (I hope the illustrations helps with that part). For convenience I set the duration of the animation to 1.0. This is because the time offset is in absolute values. Doing this means that a time offset of 0.0 is at 0% into the animation (at the beginning) and a time offset of 1.0 is at 100% into the animation (at the end).

Slider

Starting really simple, we create a basic animation for the background color of a layer and add it to that layer. We set the speed of the layer to 0 to pause the animation.

CABasicAnimation *changeColor =
   [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
changeColor.fromValue = (id)[UIColor orangeColor].CGColor;
changeColor.toValue   = (id)[UIColor blueColor].CGColor;
changeColor.duration  = 1.0; // For convenience

[self.myLayer addAnimation:changeColor
                   forKey:@"Change color"];
    
self.myLayer.speed = 0.0; // Pause the animation
Then in the action method for when the slider is dragged we set the current value of the slider (also configured to go from 0 to 1) as the time offset of the layer

- (IBAction)sliderChanged:(UISlider *)sender {
    self.myLayer.timeOffset = sender.value; // Update "current time"
}
This gives the effect that as we drag the slider the current value of the animation changes and updates the background color of the layer.


The color of the layer changes as the value of the slider changes
Pull to refresh

You can also use other mechanisms like scroll events to control animation timing. This can be used to create a very custom pull to refresh animation where the animation is progressing as the user pulls down until a threshold value where you start loading new data. The animation that the scroll event controlls in my example is the stroking of a path (animating thestrokeEnd property of a shape layer) and when it reaches a threshold it will start another animations to signal that new data is loading.

Instead of a slider to control the timing we use the amount that the scroll view is dragged down. This value will be in points so it has to be normalized to be used as a time offset but that is fine because we need a drag threshold to know when to load more data anyway. The code that handles pulling down the scroll view looks like this

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = 
      scrollView.contentOffset.y+scrollView.contentInset.top;
    if (offset <= 0.0 && !self.isLoading) {
        CGFloat startLoadingThreshold = 60.0;
        CGFloat fractionDragged       = -offset/startLoadingThreshold;
        
        self.pullToRefreshShape.timeOffset = MAX(0.0, fractionDragged);
        
        if (fractionDragged >= 1.0) {
            [self startLoading];
        }
    }
}
and the animation being controlled looks like this

CABasicAnimation *writeText = 
  [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
writeText.fromValue = @0;
writeText.toValue = @1;

CABasicAnimation *move = 
  [CABasicAnimation animationWithKeyPath:@"position.y"];
move.byValue = @(-22);
move.toValue = @0;

CAAnimationGroup *group = [CAAnimationGroup animation];
group.duration = 1.0;
group.animations = @[writeText, move];
The result is that as you pull down you have direct control over the progress of the animation (i.e. the further you pull the more of the word “Load” is written). If you pull up again then the animation will move backwards.


Directly controlling the pull to refresh control using scroll events
Once you pass the threshold you start the actual loading animation and load more data. My code for doing this looks like this. I set that I’m loading to prevent timeOffset from being set in scrollViewDidScroll:, start the loading animation and adjust the content inset to prevent the scrollview from scrolling up past the loading indicator.

self.isLoading = YES;

// start the loading animation
[self.loadingShape addAnimation:[self loadingAnimation]
                         forKey:@"Write that word"];

CGFloat contentInset    = self.collectionView.contentInset.top;
CGFloat indicatorHeight = CGRectGetHeight(self.loadingIndicator.frame);
// inset the top to keep the loading indicator on screen
self.collectionView.contentInset = 
  UIEdgeInsetsMake(contentInset+indicatorHeight, 0, 0, 0);
self.collectionView.scrollEnabled = NO; // no further scrolling

[self loadMoreDataWithAnimation:^{
    // during the reload animation (where new cells are inserted)
    self.collectionView.contentInset = 
      UIEdgeInsetsMake(contentInset, 0, 0, 0);
    self.loadingIndicator.alpha = 0.0;
} completion:^{
    // reset everything
    [self.loadingShape removeAllAnimations];
    self.loadingIndicator.alpha = 1.0;
    self.collectionView.scrollEnabled = YES;
    self.pullToRefreshShape.timeOffset = 0.0; // back to the start
    self.isLoading = NO;
}];
The end result when you scroll down past the threshold looks like this


The full pull to refresh and loading animation
Controlling an animation like that is a nice little detail to add to your application and you can do some advanced group animations like this one without writing crazy amounts of code. I didn’t show it here but you can do the same kind of control with a gesture recognizer or any other direct control mechanism.

The sample pull-to-refresh project shown above can be found on GitHub.

You can use the fillMode property to fill forwards and get the animation to show the toValue after the duration has passed but the animation is going to be removed upon completion so only setting the fillMode would not be enough. You would also have to configure the animation to not be removed on completion by settingremovedOnCompletion = NO. Just be aware that the animation only affects the visuals (the presentation layer) so by doing these two things you have introduced a difference between the model and the view. The same data (the animated property) exists in two places (the value of the property and what appears on screen) but now they are out of sync. ↩

Fun fact: a negative speed (like -1) will cause the animation to go backwards in “time”. ↩

@davidronnqvist 
