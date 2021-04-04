%.
M = [ .5634 .8054 .6761 .6890;...
    .3415 .4203 .4225 .4139; ...
    .6406 .8701 .7642 .8231; ...
    .9898 .9858 .9847 .9835]'

subplot(3,1,1), bar((M), .75, 'grouped')
xlabel('Validation Groups')
ylabel('Accuracy')
title('Comparing Accuracy of modes vs fusion')

debug = 1;

