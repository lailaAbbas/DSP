z= audiorecorder ;
disp('start speaking')
recordblocking ( z , 10 );
disp('end of speaking')
%start speaking
%end  speaking 
play(z) ;
myrecording = getaudiodata (z) ;
plot(myrecording) ;
