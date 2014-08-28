var relaunch = slate.operation('relaunch');

// var nudgeRight = slate.operation('nudge', {
//     'x' : '+10%',
//     'y' : '+0'
// });
//
// var nudgeLeft = slate.operation('nudge', {
//     'x' : '-10%',
//     'y' : '+0'
// });
//
// var nudgeUp = slate.operation('nudge', {
//     'x' : '+0',
//     'y' : '-10%'
// });
//
// var nudgeDown = slate.operation('nudge', {
//     'x' : '+0',
//     'y' : '+10%'
// });
//
// slate.bind('right:ctrl;alt', function(win){
//     var screenwidth = win.screen().rect().x;
//     var rightcorner = win.topLeft().x + win.size().width;
//     if(rightcorner <= 1920) {
//         win.doOperation(nudgeRight);
//     }
//     // win.doOperation(nudgeRight);
// });

slate.bindAll({
    '1:ctrl' : relaunch,
    'esc:ctrl' : S.op('grid'),

    // Resize Bindings
    // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
    'right:ctrl' : S.op('resize', { 'width' : '+10%', 'height' : '+0' }),
    'left:ctrl' : S.op('resize', { 'width' : '-10%', 'height' : '+0' }),
    'up:ctrl' : S.op('resize', { 'width' : '+0', 'height' : '-10%' }),
    'down:ctrl' : S.op('resize', { 'width' : '+0', 'height' : '+10%' }),
    'right:alt' : S.op('resize', { 'width' : '-10%', 'height' : '+0', 'anchor' : 'bottom-right' }),
    'left:alt' : S.op('resize', { 'width' : '+10%', 'height' : '+0', 'anchor' : 'bottom-right' }),
    'up:alt' : S.op('resize', { 'width' : '+0', 'height' : '+10%', 'anchor' : 'bottom-right' }),
    'down:alt' : S.op('resize', { 'width' : '+0', 'height' : '-10%', 'anchor' : 'bottom-right' }),

    // Push Bindings
    // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
    'd:ctrl;shift' : S.op('push', { 'direction' : 'right', 'style' : 'bar-resize:screenSizeX/2' }),
    'a:ctrl;shift' : S.op('push', { 'direction' : 'left', 'style' : 'bar-resize:screenSizeX/2' }),
    'w:ctrl;shift' : S.op('push', { 'direction' : 'up', 'style' : 'bar-resize:screenSizeY' }),
    's:ctrl;shift' : S.op('push', { 'direction' : 'down', 'style' : 'bar-resize:screenSizeY/2' }),

    // Nudge Bindings
    // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
    'd:ctrl;alt' : S.op('nudge', { 'x' : '+10%', 'y' : '+0' }),
    'a:ctrl;alt' : S.op('nudge', { 'x' : '-10%', 'y' : '+0' }),
    'w:ctrl;alt' : S.op('nudge', { 'x' : '+0', 'y' : '-10%' }),
    's:ctrl;alt' : S.op('nudge', { 'x' : '+0', 'y' : '+10%' }),

    // Throw Bindings
    // NOTE: some of these may *not* work if you have not removed the expose/spaces/mission control bindings
    'd:ctrl;alt;cmd' : S.op('throw', { 'screen' : 'right' }),
    'a:ctrl;alt;cmd' : S.op('throw', { 'screen' : 'left' })
});
