\ Fruitflies
\ Based on code written for Win32Forth around the year 2000

#1 0 0 include ramen/ramen.f
require ramen/cutlet.f

\ This program was inspired by the motion of flies.
\ Usually the flies die out before things get interesting or they
\ overpopulate and prosper indefinitely.
200 constant lifespan
defer *fly

var life  var r  var g  var b  var a   var s  \ s=size

stage 2000 pool: objects

: oranges  0 0 vx 2!  1 1 0 1 r 4!  20 rnd 0 ?do  i s !  pause  loop ;
: apples   0 0 vx 2!  1 0 0 1 r 4!    50 rnd 0 ?do  i s !  pause  4 +loop ;
: randmove  0 1 0 1 r 4!  8 s !  5 rnd 2.5 -  5 rnd 2.5 -  vx 2!  8 pauses ;
: ?bore  3 rnd pfloor 0= if {  me 0 0 away  *fly  } then ;
: live  100 rnd lifespan + life ! ;
: darker  0.99 * ;
: fadeout  300 0 do  r 4@ darker r 4!  pause  loop ;
: die  0 0 vx 2!   50 pauses  0.5 0.5 0.5 1 r 4!  2 secs  fadeout  me remove ;
: mortal  live  act>  life -- ;
: ?die  life @ 0 <= -exit  die ;
: twitch  0 1 0 1 r 4!  0 perform>  begin  apples randmove oranges randmove ?bore ?die  again ;
:is *fly  objects one  mortal  twitch  draw>  r 4@ rgba  s @ circf ;

: think  stage each> act ;
: locomote  stage each>  vx x v+ ;
: playfield  stage each> draw ;
: (step)  step>  think  stage multi  locomote ;
: (show)  show>  black backdrop  playfield  wipe objects #objects . ;
: ok  (step)  (show) ;
:is warm  ok ;

viewwh 0.5 0.5 2* at  *fly  me value og
warm